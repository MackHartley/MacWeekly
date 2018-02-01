package hu.ait.macweekly;

import android.content.Intent;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class AboutPage extends AppCompatActivity {

    // KEYS
    public static final String VERSION = "versionName";

    // DATA
    String versionName;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_about_page);

        populateDataMembers();
        TextView version = (TextView)findViewById(R.id.textView3);
        version.setText("Version " + versionName);
        setTitle("About");
   }

    private void populateDataMembers() {
        Intent retrieveExtraIntent = getIntent();
        versionName = retrieveExtraIntent.getStringExtra(VERSION);
    }

}
