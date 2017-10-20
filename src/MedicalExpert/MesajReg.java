package MedicalExpert;

import java.awt.Color;
import java.awt.Font;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JLabel;

/**
 *
 * @author Catalin
 */
public class MesajReg extends JFrame 
{
    JLabel fundal;
    JLabel ico;
    Buton buton;
    JLabel cadru;
    JLabel text;
    JLabel text2;
    
    public MesajReg()
    {
        fundal = new JLabel();
        fundal.setBounds(0,0,300,200);
        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg-250.jpg")));
        
        buton = new Buton();
        buton.setText("OK");
        buton.setBounds(110,140,70,30);
        buton.addActionListener(new java.awt.event.ActionListener(){
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt)
            {
                ActiuneButon(evt);
            }
        });
        buton.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                buton.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                buton.setForeground(new Color(255,255,255,150));
            }
        });
        
        cadru = new JLabel();
        cadru.setBounds(20,20,260,160);
        cadru.setOpaque(true);
        cadru.setBackground(new Color(255,255,255,150));
        cadru.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        
        text = new JLabel("Te-ai inregistrat cu succes!");
        text.setBounds(70,50,250,30);
        text.setFont(new Font("Monaco", Font.BOLD, 14));
        
        text2 = new JLabel("Apasa OK pentru a continua!");
        text2.setBounds(50,70,250,30);
        text2.setFont(new Font("Monaco", Font.BOLD, 14));
        
        ico = new JLabel();
        ico.setBounds(30,30,30,30);
        ico.setOpaque(true);
        ico.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/ico.png")));
        
        initializare();
    }
    
    private void initializare()
    {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(300, 200));
        setPreferredSize(new java.awt.Dimension(300, 200));
        setResizable(false);
        setUndecorated(true);
        getContentPane().setLayout(null);
        getContentPane().add(buton);
        getContentPane().add(text2);
        getContentPane().add(text);
        getContentPane().add(ico);
        getContentPane().add(cadru);
        getContentPane().add(fundal);
        setLocationRelativeTo(null);
        pack();
    }
    
    private void ActiuneButon(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
        this.dispose();
        boolean verifica = Register.Verifica();
        if(verifica == true)
        {
            Register.getMainFrame().dispose();
        }
        Start.getMainFrame().setVisible(true);
    }
}
