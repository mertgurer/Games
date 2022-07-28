package main;

import javax.swing.*;
import java.awt.*;

public class GamePanel extends JPanel implements Runnable{

    KeyHandler keyH = new KeyHandler();
    Thread gameThread;

    static final double FPS = 60;

    int boxX = 100;
    int boxY = 100;
    int boxW = 80;
    int boxH = 80;  

    int boxSpeedY = 0;   
    final int maxSpeedY = 20;

    boolean jumpFlag = false;

    public GamePanel(){
        this.setBackground(new Color(50, 50, 50));
        this.setDoubleBuffered(true);
        this.addKeyListener(keyH);
        this.setFocusable(true);
    }

    public void startGameThread(){
        gameThread = new Thread(this);
        gameThread.start();
    }

    @Override
    public void run() {

        final double drawInterval = 1000000000 / FPS;
        double delta = 0;
        long lastTime = System.nanoTime();
        long  currentTime;
        long timer = 0;
        int drawCount = 0;

        while(gameThread != null){

            currentTime = System.nanoTime();
            delta += currentTime - lastTime;
            timer += currentTime - lastTime;
            lastTime = currentTime;

            if(delta >= drawInterval){
                
                update();
                repaint();

                delta -= drawInterval;
                drawCount++;
            }

            if(timer>= 1000000000){
                System.out.println("FPS: " + drawCount);
                drawCount = 0;
                timer = 0;
            }
        }
    }

    public void update(){       
        if(boxY + boxH < 600 && boxSpeedY < maxSpeedY){            
            boxSpeedY++;
        }        
        if(boxY + boxH > 600){
            boxSpeedY = 0;
            if(!keyH.spacePressed) jumpFlag = true;
        }


        if(keyH.spacePressed && jumpFlag){
            boxSpeedY = -maxSpeedY;
            jumpFlag = false;
        }

        boxY += boxSpeedY;

        if(keyH.leftPressed && boxX >= 5){
            boxX -= 5;
        }
        if(keyH.rightPressed && boxX + boxW <= 1275){
            boxX += 5;
        }

    }

    public void paintComponent(Graphics g){
        super.paintComponent(g);

        Graphics2D g2 = (Graphics2D)g;
        g2.setColor(new Color(150, 150, 150));
        g2.fillRect(0, 610, Main.width, 75);

        g2.setColor(Color.white);
        g2.fillRect(boxX, boxY, boxW, boxH);

        g2.dispose();
    }
}
