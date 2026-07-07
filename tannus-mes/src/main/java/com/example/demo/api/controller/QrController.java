package com.example.demo.api.controller;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.ByteArrayOutputStream;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@Controller
public class QrController {

    @GetMapping("/qr/generate")
    public ResponseEntity<byte[]> generateQr(
            @RequestParam String type,
            @RequestParam String model,
            @RequestParam String color,
            @RequestParam String hardness,
            @RequestParam int boxQty
    ) throws Exception {

        String packDate = LocalDate.now().toString();

        String qrText =
                "TYPE=" + type
                        + "|MODEL=" + model
                        + "|COLOR=" + color
                        + "|HARDNESS=" + hardness
                        + "|BOX_QTY=" + boxQty
                        + "|PACK_DATE=" + packDate;

        Map<EncodeHintType, Object> hints = new HashMap<>();
        hints.put(EncodeHintType.CHARACTER_SET, StandardCharsets.UTF_8.name());
        hints.put(EncodeHintType.MARGIN, 1);

        BitMatrix bitMatrix = new MultiFormatWriter().encode(
                qrText,
                BarcodeFormat.QR_CODE,
                260,
                260,
                hints
        );

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix, "PNG", outputStream);

        String fileName = "qr_" + type + "_" + model + "_" + color + "_" + hardness + ".png";

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"")
                .contentType(MediaType.IMAGE_PNG)
                .body(outputStream.toByteArray());
    }
}