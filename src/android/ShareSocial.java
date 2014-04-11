package org.nypr.cordova.sharesocialplugin;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;

public class ShareSocial extends CordovaPlugin {

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		boolean ret=true;
		try {
			// get arguments
			JSONObject jo = args.getJSONObject(0);
			// send to share...
			sendIntent(jo.getString("subject"), jo.getString("text"));
			// indicate success
			callbackContext.success();
		} catch (JSONException e) {
			callbackContext.error("Social Sharing error -- Invalid Arguents -- check JSON");
			ret = false;
		} catch (Exception e) {
			callbackContext.error("Social Sharing error --" + e.getMessage());
			ret = false;
		}
		return ret;
	}

	private void sendIntent(String subject, String text) {
		Intent intent = new Intent(android.content.Intent.ACTION_SEND);
		intent.setType("text/plain");
		intent.putExtra(android.content.Intent.EXTRA_SUBJECT, subject);
		intent.putExtra(android.content.Intent.EXTRA_TEXT, text);
		// use createChooser to hide the 'Always' and 'Just Once' options 
		this.cordova.startActivityForResult(this, Intent.createChooser(intent, "Share"), 0);
	}

}
