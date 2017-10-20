package MedicalExpert;

import static MedicalExpert.Start.user;
import java.awt.Color;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

/**
 *
 * @author Catalin
 */
public class Profil extends JFrame {
    
    JLabel cadru_mic;
    JLabel cadru_mare;
    JLabel fundal;
    JPanel panou;
    JLabel nume;
    JLabel label_parola;
    JLabel label_username;
    JLabel label_varsta;
    JPasswordField parola;
    JTextField username;
    JTextField varsta;
    Buton modifica;
    Buton inapoi;
    
    public Profil()
    {  
        proprietati_obiecte();
        initializare();
    }
    
    private void proprietati_obiecte()
    {
        cadru_mic = new JLabel();
        cadru_mare = new JLabel();
        fundal = new JLabel();
        nume = new JLabel();
        parola = new JPasswordField();
        username = new JTextField();
        varsta = new JTextField();
        modifica = new Buton();
        panou = new JPanel();
        label_parola = new JLabel("Parola");
        label_username = new JLabel("Nume utilizator");
        label_varsta = new JLabel("Varsta");
        inapoi = new Buton();
        
        cadru_mic.setBounds(20,10,760,120);
        cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/date-opac.png")));
        cadru_mic.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
         cadru_mic.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/date.png")));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/date-opac.png")));
            }
        });
        
        cadru_mare.setBounds(20,140,760,410);
        cadru_mare.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        cadru_mare.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        
        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/start.jpg")));
        fundal.setBounds(0, 0, 800, 600);
        
        panou.setBounds(30,150,740,390);
        panou.setOpaque(true);
        panou.setBackground(new Color(255,255,255,150));
        panou.setLayout(null);
        panou.add(nume);
        panou.add(parola);
        panou.add(username);
        panou.add(varsta);
        panou.add(modifica);
        panou.add(label_parola);
        panou.add(label_varsta);
        panou.add(label_username);
        panou.add(inapoi);
        nume.setBounds(10,10,720,50);
        nume.setOpaque(true);
        nume.setFont(new Font("Monaco",1,14));
        nume.setHorizontalAlignment(JLabel.CENTER);
        label_parola.setHorizontalAlignment(JLabel.CENTER);
        label_varsta.setHorizontalAlignment(JLabel.CENTER);
        label_username.setHorizontalAlignment(JLabel.CENTER);
        label_username.setBounds(100,100,100,30);
        label_parola.setBounds(320,100,100,30);
        label_varsta.setBounds(540,100,100,30);
        label_username.setFont(new Font("Monaco",1,13));
        label_varsta.setFont(new Font("Monaco",1,13));
        label_parola.setFont(new Font("Monaco",1,13));
        username.setBounds(100,140,120,30);
        parola.setBounds(310,140,120,30);
        varsta.setBounds(530,140,120,30);
        username.setBorder(null);
        parola.setBorder(null);
        varsta.setBorder(null);
        username.setHorizontalAlignment(SwingConstants.CENTER);
        username.setFont(new Font("Monaco", Font.ITALIC, 16));
        username.setBackground(new Color(0x80a0f7));
        parola.setHorizontalAlignment(SwingConstants.CENTER);
        parola.setFont(new Font("Monaco", Font.ITALIC, 16));
        parola.setBackground(new Color(0x80a0f7));
        varsta.setHorizontalAlignment(SwingConstants.CENTER);
        varsta.setFont(new Font("Monaco", Font.ITALIC, 16));
        varsta.setBackground(new Color(0x80a0f7));
        modifica.setBounds(300,250,140,30);
        modifica.setText("Modifica datele");
        modifica.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                modifica.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                modifica.setForeground(new Color(255,255,255,150));
            }
        });
        modifica.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Modifica(evt);
            }
        });
        try { ConexiuneDB.info_editare(nume, username, varsta, user);} 
        catch (ClassNotFoundException ex) {}
        
        inapoi.setBounds(580,350,140,30);
        inapoi.setText("Acasa");
        inapoi.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                inapoi.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                inapoi.setForeground(new Color(255,255,255,150));
            }
        });
        inapoi.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Acasa(evt);
            }
        });
    }
    
    private void initializare()
    {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(800, 600));
        setPreferredSize(new java.awt.Dimension(800, 600));
        setIconImage(Toolkit.getDefaultToolkit().getImage(getClass().getResource("/pics/logo-mare.png")));
        setResizable(false);
        getContentPane().setLayout(null);
        getContentPane().add(panou);
        getContentPane().add(cadru_mic);
        getContentPane().add(cadru_mare);     
        getContentPane().add(fundal);
        pack();
        setLocationRelativeTo(null);
    }
    
    private void Modifica(java.awt.event.ActionEvent evt)
    {
        if(parola.getText().isEmpty())
                {
                    JOptionPane.showMessageDialog(null, "Campul parola nu poate fi gol!");
                }
        else 
        {
            try { 
                ConexiuneDB.editare(username, parola, varsta, user);
                this.dispose();
                Start.getMainFrame().setVisible(true);
                JOptionPane.showMessageDialog(null,"Logheaza-te din nou pentru a continua");
            }
            catch (ClassNotFoundException ex) {}
        }
    }
    
    private void Acasa(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
        new Acasa().setVisible(true);
    }
}
