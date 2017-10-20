package MedicalExpert;

import java.awt.Color;
import java.awt.Font;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

/**
 *
 * @author Catalin
 */
public class Info extends JFrame
{
    JLabel fundal;
    JLabel ico;
    Buton buton;
    JLabel panou;
    JTextField text;
    
    public Info()
    {
        Proprietati_obiecte();
        Initializare();
    }
    
    private void Initializare()
    {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(300, 200));
        setPreferredSize(new java.awt.Dimension(300, 200));
        setResizable(false);
        setUndecorated(true);
        getContentPane().setLayout(null);
        getContentPane().add(text);
        getContentPane().add(buton);
        getContentPane().add(ico);
        getContentPane().add(panou);
        getContentPane().add(fundal);
        setLocationRelativeTo(null);
        pack();
    }
    
    private void Proprietati_obiecte()
    {
        fundal = new JLabel();
        fundal.setBounds(0,0,300,200);
        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg-250.jpg")));       
        panou = new JLabel();
        buton = new Buton();
        ico = new JLabel();
        text = new JTextField();
        ico.setBounds(30,30,30,30);
        ico.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/ico.png")));
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
        panou.setBounds(10,10,280,180);
        panou.setOpaque(true);
        panou.setBackground(new Color(255,255,255,150));
        text.setBounds(35,80,240,30);
        text.setHorizontalAlignment(SwingConstants.CENTER);
        text.setEditable(false);
        text.setBorder(null);
        text.setOpaque(false);
        text.setText("Completeaza toate spatiile libere!");
        text.setFont(new Font("Monaco", Font.BOLD, 14));
    }
    
    private void ActiuneButon(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
    }
}
