package br.com.fiap.util;

import org.bson.Document;

public class CastUtils {
    public static Double getDouble(Document doc, String key) {
        Object v = doc.get(key);
        if (v == null) return null;
        if (v instanceof Number n) return n.doubleValue();
        return null;
    }

    public static Integer getInteger(Document doc, String key) {
        Object v = doc.get(key);
        if (v == null) return null;
        if (v instanceof Number n) return n.intValue();
        return null;
    }
}
