package com.example.demo.api.controller;

import com.example.demo.api.domain.ExportChangeRequest;
import com.example.demo.api.domain.ExportOrder;
import com.example.demo.api.domain.ExportOrderDetail;
import com.example.demo.api.domain.PackingOrder;
import com.example.demo.api.domain.PackingOrderDetail;
import com.example.demo.api.domain.UnplannedExport;
import com.example.demo.api.domain.UnplannedPurchase;
import com.example.demo.api.service.ExportChangeRequestService;
import com.example.demo.api.service.ExportOrderService;
import com.example.demo.api.service.ExportOutboundScanService;
import com.example.demo.api.service.ItemService;
import com.example.demo.api.service.PackingInboundScanService;
import com.example.demo.api.service.PackingOrderService;
import com.example.demo.api.service.UnplannedExportService;
import com.example.demo.api.service.UnplannedPurchaseService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.ArrayList;

import java.util.List;

@Controller
@RequestMapping("/logistics")
public class LogisticsDashboardController {

    private final PackingOrderService packingOrderService;
    private final UnplannedPurchaseService unplannedPurchaseService;
    private final ItemService itemService;
    private final ExportOrderService exportOrderService;
    private final ExportChangeRequestService exportChangeRequestService;
    private final UnplannedExportService unplannedExportService;
    private final PackingInboundScanService packingInboundScanService;
    private final ExportOutboundScanService exportOutboundScanService;

    public LogisticsDashboardController(PackingOrderService packingOrderService,
                                        UnplannedPurchaseService unplannedPurchaseService,
                                        ItemService itemService,
                                        ExportOrderService exportOrderService,
                                        ExportChangeRequestService exportChangeRequestService,
                                        UnplannedExportService unplannedExportService,
                                        PackingInboundScanService packingInboundScanService,
                                        ExportOutboundScanService exportOutboundScanService) {
        this.packingOrderService = packingOrderService;
        this.unplannedPurchaseService = unplannedPurchaseService;
        this.itemService = itemService;
        this.exportOrderService = exportOrderService;
        this.exportChangeRequestService = exportChangeRequestService;
        this.unplannedExportService = unplannedExportService;
        this.packingInboundScanService = packingInboundScanService;
        this.exportOutboundScanService = exportOutboundScanService;
    }

    private boolean isNotLogisticsTeam(HttpSession session) {
        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        return loginUser == null
                || loginRole == null
                || !"물류팀".equals(String.valueOf(loginRole));
    }

    private void noCache(HttpServletResponse response) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
    }

    private boolean hasPendingUnplanned(List<UnplannedPurchase> unplannedList) {
        if (unplannedList == null || unplannedList.isEmpty()) {
            return false;
        }

        for (UnplannedPurchase item : unplannedList) {
            if ("PENDING".equals(item.getStatus())) {
                return true;
            }
        }

        return false;
    }

    private boolean hasApprovedUnplanned(List<UnplannedPurchase> unplannedList) {
        if (unplannedList == null || unplannedList.isEmpty()) {
            return false;
        }

        for (UnplannedPurchase item : unplannedList) {
            if ("APPROVED".equals(item.getStatus())) {
                return true;
            }
        }

        return false;
    }

    private boolean hasAnyInboundTarget(PackingOrder order, List<UnplannedPurchase> unplannedList) {
        if (order != null && order.getDetailList() != null && !order.getDetailList().isEmpty()) {
            return true;
        }

        return hasApprovedUnplanned(unplannedList);
    }

    private boolean hasPendingExportChange(Long exportOrderId) {
        List<Long> pendingChangeOrderIds = exportChangeRequestService.findPendingOrderIds();
        return pendingChangeOrderIds != null && pendingChangeOrderIds.contains(exportOrderId);
    }

    // 기존에 이미 SHIPPED 상태였던 지시는 packing_inbound_scan 데이터가 없을 수 있음.
    // 이 경우 상세/스캔/입고 처리 시 자동으로 BOX/EACH 단위 행을 생성한다.
    private void ensureInboundScanUnits(Long orderId, PackingOrder order) {
        if (order == null) {
            return;
        }

        if (!"SHIPPED".equals(order.getStatus())) {
            return;
        }

        if ((order.getDetailList() == null || order.getDetailList().isEmpty())
                && !hasApprovedUnplanned(
                unplannedPurchaseService.findByPackingOrderId(orderId))) {
            return;
        }

        List<?> scanList = packingInboundScanService.findByOrderId(orderId);


        for (PackingOrderDetail detail : order.getDetailList()) {
            packingInboundScanService.createScanUnits(orderId, detail);
        }

        List<UnplannedPurchase> unplannedList =
                unplannedPurchaseService.findByPackingOrderId(orderId);

        if (unplannedList != null) {
            for (UnplannedPurchase item : unplannedList) {
                if (!"APPROVED".equals(item.getStatus())) {
                    continue;
                }

                packingInboundScanService.createUnplannedScanUnits(orderId, item);
            }
        }
    }

    // 수출 출고 스캔도 포장팀 입고처럼 BOX/EACH 단위로 자동 생성한다.
    private void ensureExportOutboundScanUnits(Long orderId, ExportOrder order) {
        if (order == null) {
            return;
        }

        if (!"READY_TO_SHIP".equals(order.getStatus()) && !"READY_DONE".equals(order.getStatus())) {
            return;
        }

        List<UnplannedExport> unplannedExportList =
                unplannedExportService.findByExportOrderId(orderId);

        exportOutboundScanService.refreshScanUnits(
                orderId,
                order.getDetailList(),
                unplannedExportList
        );
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session,
                            HttpServletResponse response,
                            Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));

        model.addAttribute("inboundWaitingCount", packingOrderService.countInboundWaiting());
        model.addAttribute("inboundDoneCount", packingOrderService.countInboundDone());

        model.addAttribute("exportWaitingCount", exportOrderService.countWaiting());
        model.addAttribute("exportReadyCount", exportOrderService.countReady());
        model.addAttribute("exportDoneCount", exportOrderService.countDone());

        return "logistics/dashboard";
    }

    @GetMapping("/list")
    public String list(@RequestParam(required = false) String month,
                       HttpSession session,
                       HttpServletResponse response,
                       Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        List<PackingOrder> orderList = packingOrderService.findAll();

        if (month != null && !month.isBlank()) {
            List<PackingOrder> filteredList = new ArrayList<>();

            for (PackingOrder order : orderList) {
                if (order.getRequestDate() != null
                        && String.valueOf(order.getRequestDate()).startsWith(month)) {
                    filteredList.add(order);
                }
            }

            orderList = filteredList;
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("orderList", orderList);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("orderMonths", packingOrderService.findOrderMonths());

        return "logistics/list";
    }

    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id,
                         HttpSession session,
                         HttpServletResponse response,
                         Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findLogisticsDetailById(id);

        if (order == null) {
            return "redirect:/logistics/list";
        }

        ensureInboundScanUnits(id, order);

        List<UnplannedPurchase> unplannedList =
                unplannedPurchaseService.findByPackingOrderId(id);

        boolean hasPendingUnplanned = hasPendingUnplanned(unplannedList);
        boolean hasAnyInboundTarget = hasAnyInboundTarget(order, unplannedList);

        int normalScanDoneCount = packingInboundScanService.countDoneByOrderId(id);
        int normalScanWaitingCount = packingInboundScanService.countWaitingByOrderId(id);

        boolean canConfirmReceive = "SHIPPED".equals(order.getStatus())
                && hasAnyInboundTarget
                && normalScanDoneCount > 0
                && normalScanWaitingCount == 0;

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", order);
        model.addAttribute("unplannedList", unplannedList);
        model.addAttribute("inboundScanList", packingInboundScanService.findByOrderId(id));
        model.addAttribute("hasPendingUnplanned", hasPendingUnplanned);
        model.addAttribute("allInboundDone", normalScanWaitingCount == 0);
        model.addAttribute("canConfirmReceive", canConfirmReceive);
        model.addAttribute("normalScanDoneCount", normalScanDoneCount);
        model.addAttribute("normalScanWaitingCount", normalScanWaitingCount);

        return "logistics/detail";
    }


    @PostMapping("/inbound/{id}")
    public String inbound(@PathVariable Long id,
                          @RequestParam("qrType") String qrType,
                          @RequestParam(required = false) Long detailId,
                          @RequestParam(required = false) Long unplannedId,
                          @RequestParam(required = false) String unitType,
                          @RequestParam(required = false) Integer unitNo,
                          HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findLogisticsDetailById(id);

        if (order == null) {
            return "redirect:/logistics/list";
        }

        if (!"SHIPPED".equals(order.getStatus())) {
            return "redirect:/logistics/detail/" + id;
        }

        ensureInboundScanUnits(id, order);

        if ("PACKING".equals(qrType)) {
            if (detailId == null || unitType == null || unitNo == null) {
                return "redirect:/logistics/scan/" + id;
            }

            packingInboundScanService.scanDone(id, detailId, unitType, unitNo);
            return "redirect:/logistics/detail/" + id;
        }

        if ("UNPLANNED".equals(qrType)) {
            if (unplannedId == null || unitType == null || unitNo == null) {
                return "redirect:/logistics/scan/" + id;
            }

            UnplannedPurchase item = unplannedPurchaseService.findById(unplannedId);

            if (item == null || item.getPackingOrderId() == null || !item.getPackingOrderId().equals(id)) {
                return "redirect:/logistics/scan/" + id;
            }

            String scanUnitType = unitType;

            if ("UNPLANNED".equals(unitType)) {
                scanUnitType = "UNPLANNED_BOX";
            }

            packingInboundScanService.scanDone(id, unplannedId, scanUnitType, unitNo);

            int waitingCount = packingInboundScanService.countWaitingByUnplannedId(unplannedId);

            if (waitingCount == 0) {
                unplannedPurchaseService.updateInboundDone(unplannedId);
            }

            return "redirect:/logistics/detail/" + id;
        }

        return "redirect:/logistics/scan/" + id;
    }

    @PostMapping("/inbound/cancel/{detailId}")
    @ResponseBody
    public String cancelInbound(@PathVariable Long detailId,
                                HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "NO_AUTH";
        }

        packingOrderService.cancelInbound(detailId);

        return "OK";
    }


    @PostMapping("/inbound/scan/cancel/{scanId}")
    @ResponseBody
    public String cancelInboundScan(@PathVariable Long scanId,
                                    HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "NO_AUTH";
        }

        packingInboundScanService.cancelScan(scanId);

        return "OK";
    }

    @PostMapping("/unplanned/inbound/cancel/{id}")
    @ResponseBody
    public String cancelUnplannedInbound(@PathVariable Long id,
                                         HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "NO_AUTH";
        }

        unplannedPurchaseService.cancelInbound(id);

        return "OK";
    }

    @PostMapping("/unplanned/delete/{id}")
    @ResponseBody
    public String deleteUnplanned(@PathVariable Long id,
                                  HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "NO_AUTH";
        }

        unplannedPurchaseService.delete(id);

        return "OK";
    }

    @PostMapping("/receive/confirm/{id}")
    public String confirmReceive(@PathVariable Long id,
                                 HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findLogisticsDetailById(id);

        if (order == null) {
            return "redirect:/logistics/list";
        }

        if (!"SHIPPED".equals(order.getStatus())) {
            return "redirect:/logistics/detail/" + id;
        }

        ensureInboundScanUnits(id, order);

        /*
         * 핵심 변경
         * - 스캔 완료된 수량이 1개라도 있으면 그 수량만 입고 확정한다.
         * - 스캔대기/누락 수량이 남아 있어도 지시는 RECEIVED로 마감한다.
         * - 못 잡은 잔여 수량은 같은 지시에서 계속 붙잡지 않고 긴급/추가입고에서 별도 등록한다.
         */
        int doneCount = packingInboundScanService.countDoneByOrderId(id);

        int waitingCount = packingInboundScanService.countWaitingByOrderId(id);

        if (waitingCount > 0) {
            return "redirect:/logistics/detail/" + id;
        }

        List<UnplannedPurchase> unplannedList =
                unplannedPurchaseService.findByPackingOrderId(id);

        boolean hasDoneUnplanned = false;

        if (unplannedList != null) {
            for (UnplannedPurchase item : unplannedList) {
                if ("APPROVED".equals(item.getStatus())
                        && "DONE".equals(item.getInboundStatus())
                        && !"Y".equals(item.getStockApplied())) {
                    hasDoneUnplanned = true;
                    break;
                }
            }
        }

        if (doneCount <= 0 && !hasDoneUnplanned) {
            return "redirect:/logistics/detail/" + id;
        }

        if (order.getDetailList() != null) {
            for (PackingOrderDetail detail : order.getDetailList()) {

                int addQty = packingInboundScanService.sumDoneQtyNotApplied(detail.getId());

                if (addQty <= 0) {
                    continue;
                }

                String memo = "부분입고";

                if (detail.getTotalQty() != null && addQty == detail.getTotalQty()) {
                    memo = "정상입고";
                }

                itemService.increaseStockFromPackingDetailQty(
                        detail,
                        addQty,
                        memo
                );

                packingInboundScanService.applyStockByDetailId(detail.getId());
            }
        }

        if (unplannedList != null) {

            for (UnplannedPurchase item : unplannedList) {

                if (!"APPROVED".equals(item.getStatus())) {
                    continue;
                }

                if (!"DONE".equals(item.getInboundStatus())) {
                    continue;
                }

                if ("Y".equals(item.getStockApplied())) {
                    continue;
                }

                itemService.increaseStockFromUnplanned(item);
                unplannedPurchaseService.updateStockApplied(item.getId());
            }
        }

        /*
         * 기존에는 hasAppliedStock == false면 여기서 return 되어
         * 이미 재고반영완료된 건이 RECEIVED로 넘어가지 못할 수 있었다.
         * 그래서 재고 반영 여부와 관계없이, 스캔완료 건이 있으면 지시는 입고완료로 마감한다.
         */
        packingOrderService.updateStatus(id, "RECEIVED");

        return "redirect:/logistics/done-list";
    }

    @GetMapping("/done-list")
    public String doneList(@RequestParam(required = false) String month,
                           HttpSession session,
                           HttpServletResponse response,
                           Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        List<PackingOrder> orderList = packingOrderService.findInboundDoneOrders();

        if (month != null && !month.isBlank()) {
            List<PackingOrder> filteredList = new ArrayList<>();

            for (PackingOrder order : orderList) {
                if (order.getRequestDate() != null
                        && String.valueOf(order.getRequestDate()).startsWith(month)) {
                    filteredList.add(order);
                }
            }

            orderList = filteredList;
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("orderList", orderList);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("orderMonths", packingOrderService.findOrderMonths());

        return "logistics/done-list";
    }

    @GetMapping("/export/list")
    public String exportList(@RequestParam(required = false) String month,
                             HttpSession session,
                             HttpServletResponse response,
                             Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        List<ExportOrder> orderList;

        if (month != null && !month.isBlank()) {
            orderList = exportOrderService.findByMonth(month);
        } else {
            orderList = exportOrderService.findAll();
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("orderList", orderList);
        model.addAttribute("selectedMonth", month);
        model.addAttribute("orderMonths", exportOrderService.findOrderMonths());
        model.addAttribute("pendingChangeOrderIds", exportChangeRequestService.findPendingOrderIds());

        return "logistics/export-list";
    }

    @GetMapping("/export/ready-list")
    public String exportReadyList(HttpSession session,
                                  HttpServletResponse response,
                                  Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        List<ExportOrder> orderList = exportOrderService.findByStatus("READY_TO_SHIP");
        orderList.addAll(exportOrderService.findByStatus("READY_DONE"));

        model.addAttribute("orderList", orderList);
        model.addAttribute("pendingChangeOrderIds", exportChangeRequestService.findPendingOrderIds());

        return "logistics/export-ready-list";
    }

    @GetMapping("/export/done-list")
    public String exportDoneList(HttpSession session,
                                 HttpServletResponse response,
                                 @RequestParam(required = false) String month,
                                 Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));

        if (month == null || month.isBlank()) {
            model.addAttribute("orderList", exportOrderService.findByStatus("DONE"));
        } else {
            model.addAttribute("orderList", exportOrderService.findByMonth(month));
        }

        model.addAttribute("monthList", exportOrderService.findOrderMonths());
        model.addAttribute("selectedMonth", month);
        model.addAttribute("pendingChangeOrderIds", exportChangeRequestService.findPendingOrderIds());

        return "logistics/export-done-list";
    }

    @GetMapping("/export/detail/{id}")
    public String exportDetail(@PathVariable Long id,
                               HttpSession session,
                               HttpServletResponse response,
                               Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", order);
        List<UnplannedExport> unplannedExportList =
                unplannedExportService.findByExportOrderId(id);

        boolean hasPendingUnplannedExport = false;

        for (UnplannedExport item : unplannedExportList) {
            if ("PENDING".equals(item.getStatus())) {
                hasPendingUnplannedExport = true;
                break;
            }
        }

        model.addAttribute("unplannedExportList", unplannedExportList);
        model.addAttribute("hasPendingUnplannedExport", hasPendingUnplannedExport);
        model.addAttribute("pendingChangeOrderIds", exportChangeRequestService.findPendingOrderIds());

        return "logistics/export-detail";
    }

    @PostMapping("/export/ready/{id}")
    public String exportReady(@PathVariable Long id,
                              HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        if (hasPendingExportChange(id)) {
            return "redirect:/logistics/export/detail/" + id;
        }
        List<UnplannedExport> unplannedList =
                unplannedExportService.findByExportOrderId(id);

        for (UnplannedExport item : unplannedList) {
            if ("PENDING".equals(item.getStatus())) {
                return "redirect:/logistics/export/detail/" + id;
            }
        }

        if (!"WAITING".equals(order.getStatus())) {
            return "redirect:/logistics/export/detail/" + id;
        }

        exportOrderService.updateStatus(id, "READY_TO_SHIP");

        // 출고준비로 넘기는 순간 BOX/EACH 스캔 단위 생성
        order.setStatus("READY_TO_SHIP");
        ensureExportOutboundScanUnits(id, order);

        return "redirect:/logistics/export/ready-list";
    }

    @PostMapping("/export/rollback/{id}")
    public String exportRollback(@PathVariable Long id,
                                 HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        if (hasPendingExportChange(id)) {
            return "redirect:/logistics/export/detail/" + id;
        }

        if ("READY_DONE".equals(order.getStatus())) {
            exportOrderService.cancelOutboundByOrderId(id);
            exportOrderService.updateStatus(id, "READY_TO_SHIP");
            return "redirect:/logistics/export/detail/" + id;
        }

        if ("READY_TO_SHIP".equals(order.getStatus())) {
            exportOrderService.cancelOutboundByOrderId(id);
            exportOrderService.updateStatus(id, "WAITING");
            return "redirect:/logistics/export/detail/" + id;
        }

        return "redirect:/logistics/export/detail/" + id;
    }

    @GetMapping("/export/scan/{id}")
    public String exportScan(@PathVariable Long id,
                             HttpSession session,
                             HttpServletResponse response,
                             Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        if (hasPendingExportChange(id)) {
            return "redirect:/logistics/export/detail/" + id;
        }

        if (!"READY_TO_SHIP".equals(order.getStatus()) && !"READY_DONE".equals(order.getStatus())) {
            return "redirect:/logistics/export/detail/" + id;
        }

        int exportScanDoneCount = exportOutboundScanService.countDoneByOrderId(id);
        int exportScanWaitingCount = exportOutboundScanService.countWaitingByOrderId(id);

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", order);
        model.addAttribute("exportScanList", exportOutboundScanService.findByOrderId(id));
        model.addAttribute("exportScanDoneCount", exportScanDoneCount);
        model.addAttribute("exportScanWaitingCount", exportScanWaitingCount);
        model.addAttribute("pendingChangeOrderIds", exportChangeRequestService.findPendingOrderIds());

        return "logistics/export-scan";
    }

    @PostMapping("/export/complete/{id}")
    public String exportComplete(@PathVariable Long id,
                                 @RequestParam("detailId") Long detailId,
                                 @RequestParam(required = false) String unitType,
                                 @RequestParam(required = false) Integer unitNo,
                                 HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        if (hasPendingExportChange(id)) {
            return "redirect:/logistics/export/detail/" + id;
        }

        if (!"READY_TO_SHIP".equals(order.getStatus()) && !"READY_DONE".equals(order.getStatus())) {
            return "redirect:/logistics/export/detail/" + id;
        }

        if (detailId == null || unitType == null || unitNo == null) {
            return "redirect:/logistics/export/scan/" + id;
        }

        exportOutboundScanService.scanDone(id, detailId, unitType, unitNo);

        // 같은 상세ID의 BOX/EACH가 전부 DONE이면 기존 detail outbound_status도 DONE 처리
        int detailWaitingCount = exportOutboundScanService.countWaitingByDetailId(detailId);

        if (detailWaitingCount == 0) {
            exportOrderService.completeOutboundDetail(id, detailId);
        }

        // 전체 BOX/EACH가 전부 DONE이면 출고확정 가능 상태
        int orderWaitingCount = exportOutboundScanService.countWaitingByOrderId(id);
        int orderDoneCount = exportOutboundScanService.countDoneByOrderId(id);

        if (orderDoneCount > 0 && orderWaitingCount == 0) {
            exportOrderService.updateStatus(id, "READY_DONE");
            return "redirect:/logistics/export/detail/" + id;
        }

        exportOrderService.updateStatus(id, "READY_TO_SHIP");

        return "redirect:/logistics/export/scan/" + id;
    }

    @PostMapping("/export/done/{id}")
    public String exportDone(@PathVariable Long id,
                             HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        if (hasPendingExportChange(id)) {
            return "redirect:/logistics/export/detail/" + id;
        }

        if (!"READY_DONE".equals(order.getStatus())) {
            return "redirect:/logistics/export/detail/" + id;
        }

        if (!"Y".equals(order.getStockApplied())) {
            if (order.getDetailList() != null) {
                for (var detail : order.getDetailList()) {
                    if (!"DONE".equals(detail.getOutboundStatus())) {
                        continue;
                    }

                    itemService.decreaseStockFromExportDetail(detail);
                }
            }

            List<UnplannedExport> unplannedExportList =
                    unplannedExportService.findByExportOrderId(id);

            if (unplannedExportList != null) {
                for (UnplannedExport item : unplannedExportList) {
                    if (!"APPROVED".equals(item.getStatus())) {
                        continue;
                    }

                    itemService.decreaseStockFromUnplannedExport(item);
                }
            }

            exportOrderService.updateStockApplied(id, "Y");
        }

        exportOrderService.updateStatus(id, "DONE");

        return "redirect:/logistics/export/detail/" + id;
    }

    @GetMapping("/export/change-request/{id}")
    public String exportChangeRequestForm(@PathVariable Long id,
                                          HttpSession session,
                                          HttpServletResponse response,
                                          Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        if ("DONE".equals(order.getStatus())) {
            return "redirect:/logistics/export/detail/" + id;
        }

        if (hasPendingExportChange(id)) {
            return "redirect:/logistics/export/detail/" + id;
        }

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", order);
        model.addAttribute("pendingChangeOrderIds", exportChangeRequestService.findPendingOrderIds());

        return "logistics/export-change-request-form";
    }

    @PostMapping("/export/change-request/{id}")
    public String exportChangeRequestSave(@PathVariable Long id,
                                          @RequestParam String requestReason,
                                          @RequestParam String requestContent,
                                          HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        if ("DONE".equals(order.getStatus())) {
            return "redirect:/logistics/export/detail/" + id;
        }

        if (hasPendingExportChange(id)) {
            return "redirect:/logistics/export/detail/" + id;
        }

        ExportChangeRequest request = new ExportChangeRequest();
        request.setExportOrderId(id);
        request.setRequestUser(String.valueOf(session.getAttribute("loginUser")));
        request.setRequestReason(requestReason);
        request.setRequestContent(requestContent);
        request.setStatus("WAITING");

        exportChangeRequestService.save(request);
        exportOrderService.updateStatus(id, "WAITING");

        return "redirect:/logistics/export/detail/" + id;
    }

    @PostMapping("/export/unplanned/save/{id}")
    public String saveUnplannedExport(@PathVariable Long id,
                                      @ModelAttribute UnplannedExport export,
                                      HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        if ("DONE".equals(order.getStatus())) {
            return "redirect:/logistics/export/detail/" + id;
        }

        if (hasPendingExportChange(id)) {
            return "redirect:/logistics/export/detail/" + id;
        }

        export.setExportOrderId(id);
        export.setRequestUser(String.valueOf(session.getAttribute("loginUser")));

        unplannedExportService.save(export);

        return "redirect:/logistics/export/detail/" + id;
    }

    @PostMapping("/export/unplanned/delete/{id}")
    @ResponseBody
    public String deleteUnplannedExport(@PathVariable Long id,
                                        HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "NO_AUTH";
        }

        unplannedExportService.delete(id);

        return "OK";
    }


    @GetMapping("/export/print/{id}")
    public String exportPrint(@PathVariable Long id,
                              HttpSession session,
                              Model model) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        model.addAttribute("order", order);

        // 핵심 추가: 전체 QR 출력에 승인완료 무발주 출고 포함
        model.addAttribute(
                "unplannedExportList",
                unplannedExportService.findByExportOrderId(id)
        );

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));

        return "logistics/export-print";
    }

    @PostMapping("/export/cancel-scan/{orderId}")
    public String cancelExportScan(@PathVariable Long orderId,
                                   @RequestParam Long scanId,
                                   HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        exportOutboundScanService.cancelScan(scanId);
        exportOrderService.updateStatus(orderId, "READY_TO_SHIP");

        return "redirect:/logistics/export/scan/" + orderId;
    }

    @GetMapping("/export/product-print/{id}")
    public String exportProductPrint(@PathVariable Long id,
                                     HttpSession session,
                                     Model model) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/done-list";
        }

        model.addAttribute("order", order);
        model.addAttribute("unplannedExportList", unplannedExportService.findByExportOrderId(id));

        return "logistics/product-print";
    }


    @PostMapping("/export/cancel/{id}")
    public String cancelExportOrder(@PathVariable Long id,
                                    HttpSession session) {

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        exportOrderService.cancelExportOrder(id);

        return "redirect:/logistics/export/list";
    }

    @GetMapping("/scan/{id}")
    public String scan(@PathVariable Long id,
                       HttpSession session,
                       HttpServletResponse response,
                       Model model) {

        noCache(response);

        if (isNotLogisticsTeam(session)) {
            return "redirect:/";
        }

        PackingOrder order = packingOrderService.findLogisticsDetailById(id);

        if (order == null) {
            return "redirect:/logistics/list";
        }

        ensureInboundScanUnits(id, order);

        model.addAttribute("loginUser", session.getAttribute("loginUser"));
        model.addAttribute("loginRole", session.getAttribute("loginRole"));
        model.addAttribute("order", order);
        model.addAttribute("unplannedList", unplannedPurchaseService.findByPackingOrderId(id));

        // 핵심 추가: BOX / EACH 쪼개진 입고 스캔 목록
        model.addAttribute("inboundScanList", packingInboundScanService.findByOrderId(id));

        return "logistics/scan";
    }

    @GetMapping("/inbound/work-order/{id}")
    public String inboundWorkOrder(@PathVariable Long id,
                                   HttpSession session,
                                   Model model) {

        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        if (loginUser == null || loginRole == null) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("loginRole", loginRole);

        PackingOrder order = packingOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/list";
        }

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("loginRole", loginRole);
        model.addAttribute("order", order);
        model.addAttribute("unplannedList", unplannedPurchaseService.findByPackingOrderId(id));

        return "logistics/inbound-work-order";
    }

    @GetMapping("/export/work-order/{id}")
    public String exportWorkOrder(@PathVariable Long id,
                                  HttpSession session,
                                  Model model) {

        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        if (loginUser == null || loginRole == null) {
            return "redirect:/";
        }

        ExportOrder order = exportOrderService.findById(id);

        if (order == null) {
            return "redirect:/logistics/export/list";
        }

        order.setDetailList(exportOrderService.findDetailsByOrderId(id));

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("loginRole", loginRole);
        model.addAttribute("order", order);

        // 핵심 추가: 긴급/무발주 수출 품목
        model.addAttribute("unplannedExportList", unplannedExportService.findByExportOrderId(id));

        return "logistics/export-work-order";
    }

    @GetMapping("/export/report/{id}")
    public String exportReport(@PathVariable Long id,
                               HttpSession session,
                               Model model) {

        Object loginUser = session.getAttribute("loginUser");
        Object loginRole = session.getAttribute("loginRole");

        if (loginUser == null || loginRole == null) {
            return "redirect:/";
        }

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("loginRole", loginRole);

        model.addAttribute("order", exportOrderService.findById(id));

        return "logistics/export-report";
    }


}
