package org.billthefarmer.fftstest;

import android.app.Activity;
import android.graphics.Typeface;
import android.text.method.ScrollingMovementMethod;
import android.os.Bundle;
import android.widget.Scroller;
import android.widget.TextView;

public class Main extends Activity
{
    private TextView textView;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

	textView = (TextView)findViewById(R.id.text);
    }

    // On resume

    @Override
    protected void onResume()
    {
	super.onResume();

	// Start test

	String text = main();
	textView.setTypeface(Typeface.MONOSPACE);
	textView.setMovementMethod(new ScrollingMovementMethod());
	textView.setText(text);
    }

    // Native method

    private native String main();

    // Load fftstest library

    static
    {
	System.loadLibrary("fftstest");
    }
}
