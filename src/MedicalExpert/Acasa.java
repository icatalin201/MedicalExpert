package MedicalExpert;

import static MedicalExpert.Start.user;
import java.awt.Color;
import java.awt.Toolkit;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JLabel;

/**
 *
 * @author Catalin
 */
public class Acasa extends JFrame
{
    Buton digestiv;
    Buton respirator;
    Buton functionare;
    Buton asistent;
    JLabel fundal;
    JLabel cadru;
    JLabel barav;
    JLabel logo;
    JLabel titlu;
    
    JLabel panou_lateral;
    JLabel contur_panou;
    JLabel nume_lateral;
    Buton profil;
    JLabel diag_curent;
    JLabel diag;
    JLabel bara;
    JLabel recomandare;
    Buton rec;
    
    public Acasa()
    {
        digestiv = new Buton();
        respirator = new Buton();
        functionare = new Buton();
        asistent = new Buton();
        fundal = new JLabel();
        cadru = new JLabel();
        barav = new JLabel();
        logo = new JLabel();
        titlu = new JLabel();
        panou_lateral = new JLabel();
        contur_panou = new JLabel();
        nume_lateral = new JLabel();
        profil = new Buton();
        diag_curent = new JLabel();
        diag = new JLabel();
        bara = new JLabel();
        recomandare = new JLabel();
        rec = new Buton();
        proprietati_obiecte();
        initializare();
    }
    
    private void proprietati_obiecte()
    {
        cadru.setBounds(20,150,550,300);
        cadru.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        cadru.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        
        logo.setBounds(260,210,250,207);
        logo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/logo-mare-opac.png")));
        logo.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                logo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/logo-mare.png")));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                logo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/logo-mare-opac.png")));
            }
        });
        
        barav.setBounds(210,150,1,300);
        barav.setBorder(javax.swing.BorderFactory.createLineBorder(Color.GRAY));
        
        titlu.setBounds(20,90,550,50);
        
        try { ConexiuneDB.UserName(user, titlu);} 
        catch (ClassNotFoundException ex) {}
        titlu.setFont(new java.awt.Font("Copperplate Gothic Light", 1, 20));
        titlu.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        titlu.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        titlu.setBackground(new Color(255,255,255,200));
        titlu.addMouseListener(new MouseAdapter(){
            
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                titlu.setBackground(Color.white);
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                titlu.setBackground(new Color(255,255,255,200));
            }
        });

        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/start.jpg")));
        fundal.setBounds(0, 0, 800, 600);
        
        respirator.setText("Modulul Respirator");
        respirator.setBounds(40, 260, 150, 40);
        respirator.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ActiuneButonRespirator(evt);
            }
        });
        respirator.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                respirator.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                respirator.setForeground(new Color(255,255,255,150));
            }
        });
               
        digestiv.setText("Modulul Digestiv");
        digestiv.setBounds(40, 310, 150, 40);
        digestiv.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ActiuneButonDigestiv(evt);
            }
        });
        digestiv.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                digestiv.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                digestiv.setForeground(new Color(255,255,255,150));
            }
        });
        
        functionare.setText("Cum functionez?");
        functionare.setBounds(40, 190, 150, 40);
        functionare.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ActiuneButonFunctionare(evt);
            }
        });
        functionare.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                functionare.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                functionare.setForeground(new Color(255,255,255,150));
            }
        });
        
        asistent.setText("Asistent personal");
        asistent.setBounds(40, 380, 150, 40);
        asistent.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                ActiuneButonProfil(evt);
            }
        });
        asistent.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                asistent.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                asistent.setForeground(new Color(255,255,255,150));
            }
        });
        
        panou_lateral.setBounds(580,90,200,360);
        panou_lateral.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        panou_lateral.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());

        contur_panou.setBounds(590, 100, 180, 340);
        contur_panou.setOpaque(true);
        contur_panou.setBackground(new Color(255, 255, 255, 150));
        
        nume_lateral.setBounds(590,100,180,80);
        try { ConexiuneDB.UserNameLateral(user, nume_lateral);} 
        catch (ClassNotFoundException ex) {}
        nume_lateral.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        nume_lateral.setBackground(new Color(255,255,255,200));
        nume_lateral.setOpaque(true);
        nume_lateral.setBorder(javax.swing.BorderFactory.createLoweredSoftBevelBorder());
        
        profil.setBounds(610,200,140,30);
        profil.setText("Editeaza datele");
        profil.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                profil.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                profil.setForeground(new Color(255,255,255,150));
            }
        });
        profil.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Editare(evt);
            }
        });
        
        bara.setBounds(590,250,180,1);
        bara.setBorder(javax.swing.BorderFactory.createLineBorder(Color.GRAY));
        
        diag_curent.setBounds(590,251,180,40);
        diag_curent.setOpaque(true);
        diag_curent.setBackground(new Color(255, 255, 255, 200));
        diag_curent.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        diag_curent.setText("Diagnostic curent");
        diag.setBounds(590,291,180,40);
        diag.setOpaque(true);
        diag.setBackground(new Color(255, 255, 255, 200));
        diag.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        recomandare.setBounds(590,331,180,110);
        recomandare.setOpaque(true);
        recomandare.setBackground(new Color(255, 255, 255, 200));
        recomandare.setVerticalAlignment(JLabel.TOP);
        recomandare.setVerticalTextPosition(JLabel.TOP);
        recomandare.setHorizontalAlignment(JLabel.CENTER);
        recomandare.setHorizontalTextPosition(JLabel.CENTER);
        try { ConexiuneDB.Diagnostic_curent(user, diag, recomandare);} 
        catch (ClassNotFoundException ex) {}
        rec.setBounds(610,380,140,30);
        rec.setText("Vezi mai multe");
        rec.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                rec.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                rec.setForeground(new Color(255,255,255,150));
            }
        });
        rec.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Recomandari(evt);
            }
        });
        if(diag.getText().contains("diagnostic inexistent"))
        {
            rec.setVisible(false);
        }
    }
    
    private void initializare()
    {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(800, 600));
        setPreferredSize(new java.awt.Dimension(800, 600));
        setIconImage(Toolkit.getDefaultToolkit().getImage(getClass().getResource("/pics/logo-mare.png")));
        setResizable(false);
        getContentPane().setLayout(null);
        getContentPane().add(respirator);
        getContentPane().add(digestiv);
        getContentPane().add(functionare);
        getContentPane().add(asistent);
        getContentPane().add(rec);
        getContentPane().add(recomandare);
        getContentPane().add(bara);
        getContentPane().add(diag);
        getContentPane().add(diag_curent);
        getContentPane().add(profil);
        getContentPane().add(nume_lateral);
        getContentPane().add(contur_panou);
        getContentPane().add(panou_lateral);
        getContentPane().add(barav);
        getContentPane().add(titlu);
        getContentPane().add(logo);
        getContentPane().add(cadru);     
        getContentPane().add(fundal);
        setLocationRelativeTo(null);
        pack();
    }
    
    private void ActiuneButonRespirator(java.awt.event.ActionEvent evt) 
    {                                         
        this.setVisible(false);
        new Respirator().setVisible(true);
    }
    
    private void ActiuneButonDigestiv(java.awt.event.ActionEvent evt) 
    {                                         
        this.setVisible(false);
        new Digestiv().setVisible(true);
    }
    
    private void ActiuneButonFunctionare(java.awt.event.ActionEvent evt) 
    {                                         
        this.setVisible(false);
        new Functionare().setVisible(true);
    }
    
    private void ActiuneButonProfil(java.awt.event.ActionEvent evt) 
    {                                         
        this.setVisible(false);
        new Asistent().setVisible(true);
    }
    
    private void Recomandari(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
        new Asistent().setVisible(true);
    }
    
    private void Editare(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
        new Profil().setVisible(true);
    }
}
