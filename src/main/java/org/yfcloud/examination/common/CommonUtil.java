package org.yfcloud.examination.common;

import java.util.UUID;

public class CommonUtil {

	public static String getUUID() {
		String uid = UUID.randomUUID().toString();
		return uid.replace("-", "");
	}
}
