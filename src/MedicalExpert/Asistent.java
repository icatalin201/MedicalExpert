package MedicalExpert;

import static MedicalExpert.Start.user;
import java.awt.Color;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.UIManager;

/**
 *
 * @author Catalin
 */
public class Asistent extends JFrame{
    
    JLabel fundal;
    JLabel cadru_mare;
    JLabel cadru_mic;
    Buton inapoi;
    JLabel panou_lateral;
    JLabel contur_panou;
    JTabbedPane tab_panel;
    JPanel tab1;
    JPanel tab2;
    JPanel tab3;
    JLabel nume_lateral;
    Buton profil;
    JLabel diag_curent;
    JLabel diag;
    JLabel bara;
    JLabel aux;
    JScrollPane scroll;
    JTable tabel;
    JLabel actual;
    Buton buton_actual;   
    JLabel denumire;
    JTextArea despre;
    JTextArea recomandari;
    JScrollPane scroll_area1;
    JScrollPane scroll_area2;
    JLabel panou_aux;
    Buton retest;
    
    public Asistent()
    { 
        proprietati_obiecte();
        initializare();
    }
    
    private void proprietati_obiecte()
    {
        fundal = new JLabel();
        cadru_mare = new JLabel();
        cadru_mic = new JLabel();
        inapoi = new Buton();
        panou_lateral = new JLabel();
        contur_panou = new JLabel();
        UIManager.put("TabbedPane.contentOpaque", false);
        tab_panel = new JTabbedPane();
        tab1 = new JPanel();
        tab2 = new JPanel();
        tab3 = new JPanel();
        nume_lateral = new JLabel();
        profil = new Buton();
        diag_curent = new JLabel();
        diag = new JLabel();
        bara = new JLabel();
        aux = new JLabel();
        scroll = new JScrollPane();
        tabel = new JTable();
        actual = new JLabel();
        buton_actual = new Buton();
        denumire = new JLabel();
        despre = new JTextArea();
        recomandari = new JTextArea();
        scroll_area1 = new JScrollPane();
        scroll_area2 = new JScrollPane();
        panou_aux = new JLabel();
        retest = new Buton();
        
        cadru_mic.setBounds(20,10,760,120);
        cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/as-opac.png")));
        cadru_mic.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        cadru_mic.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/as.png")));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/as-opac.png")));
            }
        });
        
        cadru_mare.setBounds(20,140,550,410);
        cadru_mare.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        cadru_mare.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        
        panou_lateral.setBounds(580,140,200,410);
        panou_lateral.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        panou_lateral.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());

        contur_panou.setBounds(590, 150, 180, 390);
        contur_panou.setOpaque(true);
        contur_panou.setBackground(new Color(255, 255, 255, 150));
        
        nume_lateral.setBounds(590,150,180,80);
        try { ConexiuneDB.UserNameLateral(user, nume_lateral);} 
        catch (ClassNotFoundException ex) {}
        nume_lateral.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        nume_lateral.setBackground(new Color(255,255,255,200));
        nume_lateral.setOpaque(true);
        nume_lateral.setBorder(javax.swing.BorderFactory.createLoweredSoftBevelBorder());
        
        profil.setBounds(610,250,140,30);
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
        
        bara.setBounds(590,300,180,1);
        bara.setBorder(javax.swing.BorderFactory.createLineBorder(Color.GRAY));
        
        diag_curent.setBounds(590,320,180,40);
        diag_curent.setOpaque(true);
        diag_curent.setBackground(new Color(255, 255, 255, 200));
        diag_curent.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        diag_curent.setText("Diagnostic curent");
        diag.setBounds(590,360,180,40);
        diag.setOpaque(true);
        diag.setBackground(new Color(255, 255, 255, 200));
        diag.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        try { ConexiuneDB.Diagnostic_curent(user, diag, aux);} 
        catch (ClassNotFoundException ex) {}
        aux.setBounds(590,400,180,50);
        aux.setOpaque(true);
        aux.setBackground(new Color(255, 255, 255, 200));
        aux.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
              
        tab_panel.setBounds(20,140,550,410);
        tab_panel.setFont(new java.awt.Font("Monaco", 1, 13));
        tab1.setOpaque(true);
        tab2.setOpaque(true);
        tab3.setOpaque(true);
        tab1.setBackground(new Color(255,255,255,150));
        tab2.setBackground(new Color(255,255,255,150));
        tab3.setBackground(new Color(255,255,255,150));
        tab_panel.addTab("Stare actuala", tab1);
        tab_panel.addTab("Recomandari", tab2);
        tab_panel.addTab("Istoric diagnosticari", tab3);
        tab_panel.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        
        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/start.jpg")));
        fundal.setBounds(0, 0, 800, 600);
        
        inapoi.setText("Inapoi");
        inapoi.setBounds(610, 500, 140, 30);
        inapoi.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Inapoi(evt);
            }
        });
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
        scroll.setViewportView(tabel);
        tab3.setLayout(new GridLayout(1,1));
        tab3.add(scroll);
        try { ConexiuneDB.istoric(tabel, user);} 
        catch (ClassNotFoundException ex) {}
        tabel.setEnabled(false);
        tab1.add(actual);
        tab1.add(buton_actual);
        tab1.add(panou_aux);
        tab1.add(retest);
        tab1.setLayout(null);
        buton_actual.setText("Vezi recomandari");
        buton_actual.setBounds(190,140,160,30);
        buton_actual.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Recomandari(e);
            }
        });
        buton_actual.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                buton_actual.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                buton_actual.setForeground(new Color(255,255,255,150));
            }
        });
        
        actual.setHorizontalAlignment(JLabel.CENTER);
        actual.setBounds(20,10,500,120);
        actual.setOpaque(true);
        actual.setFont(new java.awt.Font("Monaco", Font.BOLD, 14));
        actual.setBackground(new Color(255,255,255,200));
        try { ConexiuneDB.actual(actual, user);} 
        catch (ClassNotFoundException ex) {}
        
        panou_aux.setHorizontalAlignment(JLabel.CENTER);
        panou_aux.setBounds(20,180,500,145);
        panou_aux.setOpaque(true);
        panou_aux.setFont(new java.awt.Font("Monaco", Font.BOLD, 14));
        panou_aux.setBackground(new Color(255,255,255,200));
        try { ConexiuneDB.notificare(retest, panou_aux, user);} 
        catch (ClassNotFoundException ex) {}
        retest.setText("Refa testul");
        retest.setBounds(190,335,160,30);
        retest.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Retest(e);
            }
        });
        retest.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                retest.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                retest.setForeground(new Color(255,255,255,150));
            }
        });
        
        tab2.setLayout(null);
        denumire.setOpaque(true);
        denumire.setHorizontalAlignment(JLabel.CENTER);
        denumire.setBounds(10,5,520,30);
        denumire.setBackground(new Color(255,255,255,200));
        denumire.setFont(new java.awt.Font("Monaco", Font.BOLD, 14));
        despre.setFont(new Font("Monaco", Font.PLAIN, 12));
        despre.setMargin(new Insets(12, 12, 12, 12));
        recomandari.setFont(new Font("Monaco", Font.PLAIN, 12));
        recomandari.setMargin(new Insets(12, 12, 12, 12));
        despre.setEditable(false);
        recomandari.setEditable(false);
        despre.setLineWrap(true);
        recomandari.setLineWrap(true);
        despre.setWrapStyleWord(true);
        recomandari.setWrapStyleWord(true);
        scroll_area1.setBorder(null);
        scroll_area2.setBorder(null);
        scroll_area1.setViewportView(despre);
        scroll_area1.setBounds(10,40,520,75);
        scroll_area2.setViewportView(recomandari);
        scroll_area2.setBounds(10,120,520,250);
        try { ConexiuneDB.recomandari(diag, denumire, despre, recomandari);} 
        catch (ClassNotFoundException ex) {}
        tab2.add(denumire);
        tab2.add(scroll_area1);
        tab2.add(scroll_area2);
        if(diag.getText().contains("diagnostic inexistent"))
        {
            buton_actual.setVisible(false);
            retest.setVisible(false);
            panou_aux.setVisible(false);
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
        getContentPane().add(inapoi);
        getContentPane().add(aux);
        getContentPane().add(bara);
        getContentPane().add(diag);
        getContentPane().add(diag_curent);
        getContentPane().add(profil);
        getContentPane().add(nume_lateral);
        getContentPane().add(contur_panou);
        getContentPane().add(panou_lateral);
        getContentPane().add(cadru_mic);
        getContentPane().add(tab_panel);
        getContentPane().add(cadru_mare);     
        getContentPane().add(fundal);
        pack();
        setLocationRelativeTo(null);
    }
    
    private void Inapoi(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
        new Acasa().setVisible(true);
    }
    
    private void Recomandari(java.awt.event.ActionEvent e)
    {
        tab_panel.setSelectedComponent(tab2);
    }
    
    private void Editare(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
        new Profil().setVisible(true);
    }
    
    private void Retest(java.awt.event.ActionEvent evt)
    {
        if((actual.getText().contains("Litiaza-Biliara")) || 
                (actual.getText().contains("Candidoza-Bucala")) || 
                (actual.getText().contains("Toxiinfectie-Alimentara")) ||
                (actual.getText().contains("Apendicita")) ||
                (actual.getText().contains("Enterocolita")) ||
                (actual.getText().contains("Gastrita")) ||
                (actual.getText().contains("Ulcer-Gastroduodenal")))
        {
            this.setVisible(false);
            new Digestiv().setVisible(true);
        }
        else
        {
            this.setVisible(false);
            new Respirator().setVisible(true);
        }
    }
}
