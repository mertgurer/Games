package main;

import javax.swing.JPanel;
import java.awt.*;

public class GamePanel extends JPanel implements Runnable{

    KeyHandler keyH = new KeyHandler();
    Thread gameThread;

    static final double FPS = 60;

    int boxX = 100;
    int boxY = 100;
    int boxSpeed = 4;

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
        if(keyH.upPressed){
            boxY -= boxSpeed;
        }
        if(keyH.downPressed){
            boxY += boxSpeed;
        }
        if(keyH.leftPressed){
            boxX -= boxSpeed;
        }
        if(keyH.rightPressed){
            boxX += boxSpeed;
        }

    }

    public void paintComponent(Graphics g){
        super.paintComponent(g);

        Graphics2D g2 = (Graphics2D)g;
        g2.setColor(Color.white);
        g2.fillRect(boxX, boxY, 10, 10);

        g2.dispose();
    }
}
