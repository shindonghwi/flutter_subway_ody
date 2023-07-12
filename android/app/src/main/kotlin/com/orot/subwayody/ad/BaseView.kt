package com.orot.subwayody.ad

import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.widget.FrameLayout
import androidx.core.content.ContextCompat
import org.json.JSONObject

abstract class BaseView(private val context: Context) {

    abstract val eventChannel: String

    var rootLayout: FrameLayout = FrameLayout(context).apply {
        layoutParams = getFrameLayoutParams()
        setBackgroundColor(Color.parseColor("#FFF5F5F5"))
    }

    private fun getFrameLayoutParams() = FrameLayout.LayoutParams(
        FrameLayout.LayoutParams.MATCH_PARENT,
        FrameLayout.LayoutParams.WRAP_CONTENT,
    ).apply {
        gravity = Gravity.CENTER
    }

    fun jsonToMap(jsonObject: JSONObject): Map<String, String> {
        val map: MutableMap<String, String> = HashMap()
        val keysIterator = jsonObject.keys()
        while (keysIterator.hasNext()) {
            val key = keysIterator.next()
            val value = jsonObject[key]
            map[key] = value.toString()
        }
        return map
    }


    fun applyBindingViewH50(view: View?) {
        rootLayout.run {
            removeAllViews()
            view?.layoutParams = getFrameLayoutParams()
            addView(view)
        }
    }

}