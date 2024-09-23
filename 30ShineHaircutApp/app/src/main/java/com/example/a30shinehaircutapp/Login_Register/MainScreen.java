package com.example.a30shinehaircutapp.Login_Register;

import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.ViewFlipper;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.graphics.Insets;
import androidx.core.view.GravityCompat;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import androidx.drawerlayout.widget.DrawerLayout;
import androidx.recyclerview.widget.RecyclerView;

import com.example.a30shinehaircutapp.R;
import com.google.android.material.navigation.NavigationView;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;

public class MainScreen extends AppCompatActivity {
    Toolbar toolbar;
    ViewFlipper viewFlipper;
    RecyclerView recyclerViewManHinhChinh;
    NavigationView navigationView;
    ListView listViewManHinhChinh;
    DrawerLayout drawerLayout;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_screen);
        Anh_xa();
        ActionBar();
        ActionViewFlipper();
    }

    private void ActionViewFlipper() {
        ArrayList<String> mangQuangCao = new ArrayList<>();
        mangQuangCao.add("https://i.pinimg.com/564x/be/80/16/be801685964835c09b9b16c03e19a966.jpg");
        mangQuangCao.add("https://i.pinimg.com/564x/41/68/5c/41685c2e8fb5619598389196bd027818.jpg");
        mangQuangCao.add("https://i.pinimg.com/564x/f8/02/99/f80299786944a3245cc7879976a1456c.jpg");
        mangQuangCao.add("https://i.pinimg.com/564x/2e/3f/a8/2e3fa8f709b50a8c0975bcb15d6e811e.jpg");
        mangQuangCao.add("https://i.pinimg.com/564x/a7/b9/ae/a7b9ae5d1440e38298daa9893b154f99.jpg");
        mangQuangCao.add("https://i.pinimg.com/564x/43/a3/46/43a3460326e2acce87f652bd2c06d4ce.jpg");
        for (int i = 0; i < mangQuangCao.size(); i++){
            ImageView imageView = new ImageView(getApplicationContext());
            Picasso.get().load(mangQuangCao.get(i)).into(imageView);
            imageView.setScaleType(ImageView.ScaleType.FIT_XY);
            viewFlipper.addView(imageView);
        }
        viewFlipper.setFlipInterval(5000);
        viewFlipper.setAutoStart(true);
        Animation animation_slide_in = AnimationUtils.loadAnimation(getApplicationContext(), R.anim.slide_in_right);
        Animation animation_slide_out = AnimationUtils.loadAnimation(getApplicationContext(), R.anim.slide_out_right);
        viewFlipper.setInAnimation(animation_slide_in);
        viewFlipper.setOutAnimation(animation_slide_out);
    }

    private void ActionBar(){
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        toolbar.setNavigationIcon(android.R.drawable.ic_menu_sort_by_size);
        toolbar.setNavigationOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                drawerLayout.openDrawer(GravityCompat.START);
            }
        });
    }
    private void Anh_xa(){
        toolbar = findViewById(R.id.toolbarManHinhChinh);
        viewFlipper = findViewById(R.id.viewFlipper);
        recyclerViewManHinhChinh = findViewById(R.id.recyclerView);
        navigationView = findViewById(R.id.navigationView);
        listViewManHinhChinh = findViewById(R.id.listViewManHinhChinh);
        drawerLayout = findViewById(R.id.drawerLayout);
    }
}