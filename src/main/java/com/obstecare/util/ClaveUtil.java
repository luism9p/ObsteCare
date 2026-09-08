package com.obstecare.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utilidad para transformar contrasenas en texto plano a un hash SHA-256,
 * de modo que en la base de datos nunca se almacene la contrasena original.
 */
public class ClaveUtil {

    private ClaveUtil() {
    }

    public static String hash(String textoPlano) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] bytesHash = digest.digest(textoPlano.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : bytesHash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException | java.io.UnsupportedEncodingException e) {
            throw new RuntimeException("No se pudo calcular el hash de la contrasena", e);
        }
    }
}
