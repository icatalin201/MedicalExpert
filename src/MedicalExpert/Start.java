package MedicalExpert;

import java.awt.Color;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPasswordField;
import javax.swing.JProgressBar;
import javax.swing.SwingUtilities;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

/**
 *
 * @author Catalin
 */

public final class Start extends JFrame
{  
    private static final JFrame frame = new Start();
    static JProgressBar pbar;
    static Buton buton1;
    static Buton buton3;
    static JLabel text;
    static JLabel iesire;
    static JLabel fundal;
    static JLabel cadru;
    static JTextField user;
    static JPasswordField pass;
    static final int MY_MINIMUM = 0;
    static final int MY_MAXIMUM = 100;
    
    @SuppressWarnings("OverridableMethodCallInConstructor")
     public Start() 
     {  
        buton1 = new Buton();
        buton3 = new Buton();
        iesire = new JLabel();
        fundal = new JLabel();
        cadru = new JLabel();
        text = new JLabel();
        user = new JTextField();
        pass = new JPasswordField();
        pbar = new JProgressBar();
        pbar.setMinimum(MY_MINIMUM);
        pbar.setMaximum(MY_MAXIMUM);
        pbar.setBounds(100, 250, 400, 20);
        pbar.setForeground(new java.awt.Color(51, 51, 255));
       
        text.setBounds(250,120,130,30);
        text.setText("CONECTARE");
        text.setFont(new Font("Monaco", Font.BOLD, 16));
        
        cadru.setBounds(20,20,560,460);
        cadru.setOpaque(true);
        cadru.setBackground(new Color(255,255,255,150));
        cadru.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        

        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg1.jpg")));
        fundal.setBounds(0, 0, 600, 500);
        setIconImage(Toolkit.getDefaultToolkit().getImage(getClass().getResource("/pics/logo-mare.png")));
        
        user.setBounds(230,200,145,30);
        user.setBorder(null);
        user.setHorizontalAlignment(SwingConstants.CENTER);
        user.setForeground(Color.GRAY);
        user.setText("nume utilizator");
        user.setFont(new Font("Monaco", Font.ITALIC, 16));
        user.setBackground(new Color(0x80a0f7));
        user.addFocusListener(new FocusListener() 
        {
            @Override
            public void focusGained(FocusEvent e) 
            {
                if (user.getText().equals("nume utilizator")) 
                {
                    user.setText("");
                    user.setForeground(Color.BLACK);
                    user.setFont(new Font("Monaco", Font.ITALIC, 16));
                }
            }
            @Override
            public void focusLost(FocusEvent e) 
            {
                if (user.getText().isEmpty()) 
                {   
                    user.setForeground(Color.GRAY);
                    user.setText("nume utilizator");
                    user.setFont(new Font("Monaco", Font.ITALIC, 16));
                }
            }
        });
        
        pass.setBounds(230,250,145,30);
        pass.setBorder(null);
        pass.setHorizontalAlignment(SwingConstants.CENTER);
        pass.setForeground(Color.GRAY);
        pass.setText("parola");
        pass.setFont(new Font("Monaco", Font.ITALIC, 16));
        pass.setBackground(new Color(0x80a0f7));
        pass.addFocusListener(new FocusListener() 
        {
            @Override
            public void focusGained(FocusEvent e) 
            {
                if (pass.getText().equals("parola")) 
                {
                    pass.setText("");
                    pass.setForeground(Color.BLACK);
                }
            }
            @Override
            public void focusLost(FocusEvent e) 
            {
                if (pass.getText().isEmpty()) 
                {   
                    pass.setForeground(Color.GRAY);
                    pass.setText("parola");
                }
            }
        });
         
        buton1.setText("Conectare");
        buton1.setBounds(230, 330, 145, 30);
        buton1.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ActiuneButon1(evt);
            }
            });
        buton1.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                buton1.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                buton1.setForeground(new Color(255,255,255,150));
            }
        });
        
        buton3.setText("Inregistrare");
        buton3.setBounds(30, 420, 150, 30);
        buton3.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ActiuneButon3(evt);
            }
        });
        buton3.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                buton3.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                buton3.setForeground(new Color(255,255,255,150));
            }
        });
        
        iesire = new JLabel();
        iesire.setBounds(540,30,25,25);
        iesire.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/close.png")));
        iesire.addMouseListener(new MouseAdapter(){
            
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                iesire.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/close-hover.png")));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                iesire.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/close.png")));
            }
            
            @Override
            public void mouseClicked(MouseEvent arg0)
            {
                System.exit(0);
            }
    });
        
        buton1.setVisible(false);
        buton3.setVisible(false);
        text.setVisible(false);
        iesire.setVisible(false);
        cadru.setVisible(false);
        user.setVisible(false);
        pass.setVisible(false);
    }
    
    private void ActiuneButon1(java.awt.event.ActionEvent evt)
    {      // buton logare                                   
        try 
        {
            ConexiuneDB.Logare(user,pass);
        } 
        catch (ClassNotFoundException ex) {}
    }
    
    private void ActiuneButon3(java.awt.event.ActionEvent evt) 
    {         // buton catre inregistrare                                
        this.dispose();
        Register.getMainFrame().setVisible(true);
    }
    
    @SuppressWarnings("SleepWhileInLoop")
    public static void lansare_bara()
    {
        for (int i = MY_MINIMUM; i <= MY_MAXIMUM; i++) 
        {
            int procent = i;
            try 
            {
                SwingUtilities.invokeLater(new Runnable() 
                {
                    @Override
                    public void run() {
                        pbar.setValue(procent);
                        if(procent == MY_MAXIMUM)
                        {
                            pbar.setVisible(false);
                            buton1.setVisible(true);
                            buton3.setVisible(true);
                            iesire.setVisible(true);
                            cadru.setVisible(true);
                            user.setVisible(true);
                            pass.setVisible(true);
                            text.setVisible(true);
                            fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.jpg")));
                        }
                    }
                });
                java.lang.Thread.sleep(10);
            } 
            catch (InterruptedException e) {}
        }  
    }
    
    public static final JFrame getMainFrame(){
        return frame;
    }
    
    public static void main(String[] args) 
    {
        frame.setMinimumSize(new java.awt.Dimension(600, 500));
        frame.setPreferredSize(new java.awt.Dimension(600, 500));
        frame.setResizable(false);
        frame.setUndecorated(true);
        frame.getContentPane().setLayout(null);
        frame.getContentPane().add(buton1);
        frame.getContentPane().add(buton3);
        frame.getContentPane().add(iesire);
        frame.getContentPane().add(text);
        frame.getContentPane().add(user);
        frame.getContentPane().add(pass);
        frame.getContentPane().add(cadru);       
        frame.getContentPane().add(pbar);       
        frame.getContentPane().add(fundal);
        frame.setLocationRelativeTo(null);
        frame.pack();
        frame.setVisible(true);
        lansare_bara();
    }
}