package MedicalExpert;

import static MedicalExpert.Start.user;
import java.awt.Color;
import java.awt.Insets;
import java.awt.Toolkit;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import net.sf.clipsrules.jni.Environment;
import net.sf.clipsrules.jni.FactAddressValue;
import net.sf.clipsrules.jni.MultifieldValue;

/**
 *
 * @author Catalin
 */
public class Digestiv extends JFrame{
    
Environment clips;
    JLabel intrebare;
    JLabel fundal;
    JLabel contur;
    JLabel auxiliar;
    Buton da;
    Buton nu; 
    JTextArea panou;
    JLabel labelpanou;
    JScrollPane scroll;
    Buton inapoi;
    Buton restart;
    JLabel cadru;
    JLabel cadru_mic;
    JLabel panou_lateral;
    JLabel contur_panou;
    JLabel nume_lateral;
    Buton profil;
    JLabel diag_curent;
    JLabel diag;
    JLabel bara;
    JLabel recomandare;
    Buton rec;
       
    @SuppressWarnings("Convert2Lambda")
    public Digestiv()
    {
        proprietati_obiecte();
        initializare();
    }
    
    private void proprietati_obiecte()
    {
        clips = new Environment();
        clips.load("digestiv.clp");
        clips.reset(); 
        clips.run();
        
        nume_lateral = new JLabel();
        profil = new Buton();
        diag_curent = new JLabel();
        diag = new JLabel();
        bara = new JLabel();
        recomandare = new JLabel();
        rec = new Buton();
        
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
        diag_curent.setBounds(590,301,180,40);
        diag_curent.setOpaque(true);
        diag_curent.setBackground(new Color(255, 255, 255, 200));
        diag_curent.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        diag_curent.setText("Diagnostic curent");
        diag.setBounds(590,341,180,40);
        diag.setOpaque(true);
        diag.setBackground(new Color(255, 255, 255, 200));
        diag.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        recomandare.setBounds(590,381,180,100);
        recomandare.setOpaque(true);
        recomandare.setBackground(new Color(255, 255, 255, 200));
        recomandare.setVerticalAlignment(JLabel.TOP);
        recomandare.setVerticalTextPosition(JLabel.TOP);
        recomandare.setHorizontalAlignment(JLabel.CENTER);
        recomandare.setHorizontalTextPosition(JLabel.CENTER);
        try { ConexiuneDB.Diagnostic_curent(user, diag, recomandare);} 
        catch (ClassNotFoundException ex) {}
        rec.setBounds(610,440,140,30);
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
        
        inapoi = new Buton();
        inapoi.setText("Inapoi");
        inapoi.setBounds(610, 495, 140, 30);
        inapoi.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                butonInapoi(evt);
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
        
        restart = new Buton();
        restart.setBounds(230,350,140,30);
        restart.setText("Continua");
        restart.addActionListener(new java.awt.event.ActionListener() {            
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                butonRestart(evt);
            }
        });
        restart.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                restart.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                restart.setForeground(new Color(255,255,255,150));
            }
        });
               
        da = new Buton();
        da.addActionListener(new java.awt.event.ActionListener() {            
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                da(evt);
            }
        });
        da.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                da.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                da.setForeground(new Color(255,255,255,150));
            }
        });
        
        nu = new Buton();
        nu.addActionListener(new java.awt.event.ActionListener() {            
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                nu(evt);
            }
        });
        nu.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                nu.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                nu.setForeground(new Color(255,255,255,150));
            }
        });
        
        fundal = new JLabel();
        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/start.jpg")));
        fundal.setBounds(0, 0, 800, 600);
        
        cadru = new JLabel();
        cadru.setBounds(20,140,550,410);
        cadru.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        cadru.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        
        cadru_mic = new JLabel();
        cadru_mic.setBounds(20,10,760,120);
        cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/lgd-opac.png")));
        cadru_mic.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        cadru_mic.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/lgd.png")));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/lgd-opac.png")));
            }
        });
        
        panou_lateral = new JLabel();
        panou_lateral.setBounds(580,140,200,410);
        panou_lateral.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        panou_lateral.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        
        contur_panou = new JLabel();
        contur_panou.setBorder(javax.swing.BorderFactory.createLoweredSoftBevelBorder());
        contur_panou.setBounds(590, 150, 180, 390);
        contur_panou.setOpaque(true);
        contur_panou.setBackground(new Color(255, 255, 255, 150));
         
        contur = new JLabel();
        contur.setBorder(javax.swing.BorderFactory.createLoweredSoftBevelBorder());
        contur.setBounds(30, 150, 530, 180);
        contur.setOpaque(true);
        contur.setBackground(new Color(255, 255, 255, 150));
        
        panou = new JTextArea();
        panou.setText(" Raspunsurile dumneavoastra sunt afisate mai jos: " + "\r\n");
        panou.setFont(new java.awt.Font("Monaco", 0, 15));       
        panou.setEditable(false);
        panou.setBounds(30, 350, 530, 190);
        panou.setOpaque(false);
        panou.setMargin(new Insets(12, 12, 12, 12));
        
        scroll = new JScrollPane();
        scroll.getViewport().setView(panou);
        scroll.setBounds(30, 350, 530, 190);
        scroll.setOpaque(false);
        scroll.getViewport().setOpaque(false);
        scroll.setBorder(javax.swing.BorderFactory.createLoweredBevelBorder());
        
        labelpanou = new JLabel();
        labelpanou.setBounds(30, 350, 530, 190);
        labelpanou.setOpaque(true);
        labelpanou.setBackground(new Color(255, 255, 255, 150));
                             
        intrebare = new JLabel();
        intrebare.setBounds(30, 150, 530, 110);
        intrebare.setFont(new java.awt.Font("Monaco", 0, 15));
        intrebare.setBorder(javax.swing.BorderFactory.createLoweredBevelBorder());
        intrebare.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        intrebare.setText("<html><p align=center>Acest modul poate diagnostica cu succes bolile:<br>"
                + "Ulcer-Gastroduodenal, Litiaza Biliara, Gastrita, Enterocolita, Apendicita, "
                + "Toxiinfectie alimentara, Candidoza Bucala</p></html>");
        
        auxiliar = new JLabel();
        auxiliar.setBounds(30, 170, 530, 100);
        auxiliar.setFont(new java.awt.Font("Monaco", 0, 15));
        auxiliar.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        
        da.setText("DA");
        nu.setText("NU");
        da.setOpaque(false);
        nu.setOpaque(false);
        da.setBounds(190, 280, 100, 25);
        nu.setBounds(300, 280, 100, 25);
        
        da.setVisible(false);
        nu.setVisible(false);
        panou.setVisible(false);
        scroll.setVisible(false);
        labelpanou.setVisible(false);
        restart.setVisible(true);
    }
    
    private void initializare()
    {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(800, 600));
        setPreferredSize(new java.awt.Dimension(800, 600));
        setIconImage(Toolkit.getDefaultToolkit().getImage(getClass().getResource("/pics/logo-mare.png")));
        setResizable(false);  
        getContentPane().setLayout(null);
        getContentPane().add(da);
        getContentPane().add(nu);
        getContentPane().add(inapoi);       
        getContentPane().add(restart);
        getContentPane().add(scroll);
        getContentPane().add(labelpanou);
        getContentPane().add(intrebare);        
        getContentPane().add(auxiliar);
        getContentPane().add(contur);
        getContentPane().add(rec);
        getContentPane().add(recomandare);
        getContentPane().add(bara);
        getContentPane().add(diag);
        getContentPane().add(diag_curent);
        getContentPane().add(profil);
        getContentPane().add(nume_lateral);
        getContentPane().add(contur_panou);
        getContentPane().add(panou_lateral);
        getContentPane().add(cadru_mic);
        getContentPane().add(cadru);
        getContentPane().add(fundal);
        setLocationRelativeTo(null);
        pack();
        setVisible(true);
    }
    
    public void butonRestart(java.awt.event.ActionEvent evt) 
    {
        if(intrebare.getText().contains("Diagnosticarea"))
        {
            this.setVisible(false);
            new Asistent().setVisible(true);
        }
        else 
        {
            setare_obiecte_start();
            try
            {             
                primire_intrebari();
            }
            catch(Exception ex)
            {
            ex.printStackTrace();
            }
            restart.setVisible(false);
        }
        
    }
    
    public void butonInapoi(java.awt.event.ActionEvent evt) 
    {
        this.setVisible(false);
        clips.destroy();
        new Acasa().setVisible(true);
    }
    public void da(java.awt.event.ActionEvent evt) 
    {
        setare_obiecte_start();
        try
        {       
            clips.eval("(assert (raspuns da))");
                
            if(intrebare.getText().contains("dureri in cavitatea bucala"))
                panou.setText(panou.getText() + "\r\n" + " dureri in cavitatea bucala = da");
            if(intrebare.getText().contains("secretii albicioase pe limba"))
                panou.setText(panou.getText() + "\r\n" + " secretii albicioase pe limba = da");
            if(intrebare.getText().contains("pete albe in cavitatea bucala"))
                panou.setText(panou.getText() + "\r\n" + " pete albe in cavitatea bucala = da");
            if(intrebare.getText().contains("dificultate la inghitire"))
                panou.setText(panou.getText() + "\r\n" + " dificultate la inghitire = da");
            if(intrebare.getText().contains("leziuni pe limba"))
                panou.setText(panou.getText() + "\r\n" + " leziuni pe limba, cerul gurii sau gingii = da");
            if(intrebare.getText().contains("dificultatea de a simti gustul"))
                panou.setText(panou.getText() + "\r\n" + " dificultatea de a simti gustul alimentelor = da");
            if(intrebare.getText().contains("rude"))
                panou.setText(panou.getText() + "\r\n" + " membrii in familie ce sufera de Ulcer sau Litiaza = da");
            if(intrebare.getText().contains("dureri in epigastru"))
                panou.setText(panou.getText() + "\r\n" + " dureri in epigastru = da");
            if(intrebare.getText().contains("dureri in zona hipocondrului"))
                panou.setText(panou.getText() + "\r\n" + " dureri hipocondrul drept = da");
            if(intrebare.getText().contains("apare dupa masa"))
                panou.setText(panou.getText() + "\r\n" + " dureri dupa masa = da");
            if(intrebare.getText().contains("accentuata noaptea"))
                panou.setText(panou.getText() + "\r\n" + " dureri accentuate noaptea = da");
            if(intrebare.getText().contains("scaune deschise la culoare"))
                panou.setText(panou.getText() + "\r\n" + " scaune deschise la culoare = da");
            if(intrebare.getText().contains("albul ochilor"))
                panou.setText(panou.getText() + "\r\n" + " semne de icter = da");
            if(intrebare.getText().contains("Urina dumneavoastra are o culoare"))
                panou.setText(panou.getText() + "\r\n" + " urina de culoare inchisa = da");
            if(intrebare.getText().contains("febra"))
                panou.setText(panou.getText() + "\r\n" + " febra = da");
            if(intrebare.getText().contains("dureri abdominale"))
                panou.setText(panou.getText() + "\r\n" + " dureri abdominale = da");
            if(intrebare.getText().contains("in partea dreapta"))
                panou.setText(panou.getText() + "\r\n" + " dureri abdominale in dreapta = da");
            if(intrebare.getText().contains("dureri la palpare"))
                panou.setText(panou.getText() + "\r\n" + " dureri la palparea abdomenului = da");
            if(intrebare.getText().contains("este umflat"))
                panou.setText(panou.getText() + "\r\n" + " abdomen umflat = da");
            if(intrebare.getText().contains("crampe abdominale"))
                panou.setText(panou.getText() + "\r\n" + " crampe abdominale = da");
            if(intrebare.getText().contains("durere cand urinati"))
                panou.setText(panou.getText() + "\r\n" + " dureri in timpul urinarii = da");
            if(intrebare.getText().contains("dureri de cap"))
                panou.setText(panou.getText() + "\r\n" + " dureri de cap = da");
            if(intrebare.getText().contains("indigestie"))
                panou.setText(panou.getText() + "\r\n" + " indigestie = da");
            if(intrebare.getText().contains("stari de greata si voma"))
                panou.setText(panou.getText() + "\r\n" + " stari de greata si voma = da");
            if(intrebare.getText().contains("greata si voma se manifesta"))
                panou.setText(panou.getText() + "\r\n" + " stari de greata si voma dupa masa = da");
            if(intrebare.getText().contains("scadere in greutate"))
                panou.setText(panou.getText() + "\r\n" + " scadere in greutate = da");
            if(intrebare.getText().contains("scaune de culoare negru inchis"))
                panou.setText(panou.getText() + "\r\n" + " scaune de culoare inchisa = da");
            if(intrebare.getText().contains("diaree"))
                panou.setText(panou.getText() + "\r\n" + " diaree = da");
            if(intrebare.getText().contains("balonat"))
                panou.setText(panou.getText() + "\r\n" + " balonare = da");
            if(intrebare.getText().contains("pofta de mancare"))
                panou.setText(panou.getText() + "\r\n" + " lipsa pofta de mancare = da");
            if(intrebare.getText().contains("epuizat"))
                panou.setText(panou.getText() + "\r\n" + " epuizare = da");
            if(intrebare.getText().contains("zgomote intestinale"))
                panou.setText(panou.getText() + "\r\n" + " zgomote intestinale = da");
            if(intrebare.getText().contains("deshidratat"))
                panou.setText(panou.getText() + "\r\n" + " deshidratare = da");
            if(intrebare.getText().contains("ameteli"))
                panou.setText(panou.getText() + "\r\n" + " ameteli = da");
            if(intrebare.getText().contains("muschii slabiti"))
                panou.setText(panou.getText() + "\r\n" + " slabire musculara = da");
            if(intrebare.getText().contains("arsura"))
                panou.setText(panou.getText() + "\r\n" + " senzatia de arsura la nivelul stomacului = da");
            
            primire_intrebari();
            returneaza_diagnostic();
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    public void nu(java.awt.event.ActionEvent evt) 
    {
        setare_obiecte_start();
        try
        {       
            clips.eval("(assert (raspuns nu))");
                
            if(intrebare.getText().contains("dureri in cavitatea bucala"))
                panou.setText(panou.getText() + "\r\n" + " dureri in cavitatea bucala = nu");
            if(intrebare.getText().contains("secretii albicioase pe limba"))
                panou.setText(panou.getText() + "\r\n" + " secretii albicioase pe limba = nu");
            if(intrebare.getText().contains("pete albe in cavitatea bucala"))
                panou.setText(panou.getText() + "\r\n" + " pete albe in cavitatea bucala = nu");
            if(intrebare.getText().contains("dificultate la inghitire"))
                panou.setText(panou.getText() + "\r\n" + " dificultate la inghitire = nu");
            if(intrebare.getText().contains("leziuni pe limba"))
                panou.setText(panou.getText() + "\r\n" + " leziuni pe limba, cerul gurii sau gingii = nu");
            if(intrebare.getText().contains("dificultatea de a simti gustul"))
                panou.setText(panou.getText() + "\r\n" + " dificultatea de a simti gustul alimentelor = nu");
            if(intrebare.getText().contains("rude"))
                panou.setText(panou.getText() + "\r\n" + " membrii in familie ce sufera de Ulcer sau Litiaza = nu");
            if(intrebare.getText().contains("dureri in epigastru"))
                panou.setText(panou.getText() + "\r\n" + " dureri in epigastru = nu");
            if(intrebare.getText().contains("dureri in zona hipocondrului"))
                panou.setText(panou.getText() + "\r\n" + " dureri hipocondrul drept = nu");
            if(intrebare.getText().contains("apare dupa masa"))
                panou.setText(panou.getText() + "\r\n" + " dureri dupa masa = nu");
            if(intrebare.getText().contains("accentuata noaptea"))
                panou.setText(panou.getText() + "\r\n" + " dureri accentuate noaptea = nu");
            if(intrebare.getText().contains("scaune deschise la culoare"))
                panou.setText(panou.getText() + "\r\n" + " scaune deschise la culoare = nu");
            if(intrebare.getText().contains("albul ochilor"))
                panou.setText(panou.getText() + "\r\n" + " semne de icter = nu");
            if(intrebare.getText().contains("Urina dumneavoastra are o culoare"))
                panou.setText(panou.getText() + "\r\n" + " urina de culoare inchisa = nu");
            if(intrebare.getText().contains("febra"))
                panou.setText(panou.getText() + "\r\n" + " febra = nu");
            if(intrebare.getText().contains("dureri abdominale"))
                panou.setText(panou.getText() + "\r\n" + " dureri abdominale = nu");
            if(intrebare.getText().contains("in partea dreapta"))
                panou.setText(panou.getText() + "\r\n" + " dureri abdominale in dreapta = nu");
            if(intrebare.getText().contains("dureri la palpare"))
                panou.setText(panou.getText() + "\r\n" + " dureri la palparea abdomenului = nu");
            if(intrebare.getText().contains("este umflat"))
                panou.setText(panou.getText() + "\r\n" + " abdomen umflat = nu");
            if(intrebare.getText().contains("crampe abdominale"))
                panou.setText(panou.getText() + "\r\n" + " crampe abdominale = nu");
            if(intrebare.getText().contains("durere cand urinati"))
                panou.setText(panou.getText() + "\r\n" + " dureri in timpul urinarii = nu");
            if(intrebare.getText().contains("dureri de cap"))
                panou.setText(panou.getText() + "\r\n" + " dureri de cap = nu");
            if(intrebare.getText().contains("indigestie"))
                panou.setText(panou.getText() + "\r\n" + " indigestie = nu");
            if(intrebare.getText().contains("stari de greata si voma"))
                panou.setText(panou.getText() + "\r\n" + " stari de greata si voma = nu");
            if(intrebare.getText().contains("greata si voma se manifesta"))
                panou.setText(panou.getText() + "\r\n" + " stari de greata si voma dupa masa = nu");
            if(intrebare.getText().contains("scadere in greutate"))
                panou.setText(panou.getText() + "\r\n" + " scadere in greutate = nu");
            if(intrebare.getText().contains("scaune de culoare negru inchis"))
                panou.setText(panou.getText() + "\r\n" + " scaune de culoare inchisa = nu");
            if(intrebare.getText().contains("diaree"))
                panou.setText(panou.getText() + "\r\n" + " diaree = nu");
            if(intrebare.getText().contains("balonat"))
                panou.setText(panou.getText() + "\r\n" + " balonare = nu");
            if(intrebare.getText().contains("pofta de mancare"))
                panou.setText(panou.getText() + "\r\n" + " lipsa pofta de mancare = nu");
            if(intrebare.getText().contains("epuizat"))
                panou.setText(panou.getText() + "\r\n" + " epuizare = nu");
            if(intrebare.getText().contains("zgomote intestinale"))
                panou.setText(panou.getText() + "\r\n" + " zgomote intestinale = nu");
            if(intrebare.getText().contains("deshidratat"))
                panou.setText(panou.getText() + "\r\n" + " deshidratare = nu");
            if(intrebare.getText().contains("ameteli"))
                panou.setText(panou.getText() + "\r\n" + " ameteli = nu");
            if(intrebare.getText().contains("muschii slabiti"))
                panou.setText(panou.getText() + "\r\n" + " slabire musculara = nu");
            if(intrebare.getText().contains("arsura"))
                panou.setText(panou.getText() + "\r\n" + " senzatia de arsura la nivelul stomacului = nu");
            
            primire_intrebari();
            returneaza_diagnostic();
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    public void primire_intrebari()
    {
        String intrebarea;
        try
        {
            clips.run();           
            MultifieldValue mv = (MultifieldValue) clips.eval("(find-all-facts ((?x intrebare-curenta)) TRUE)");
            FactAddressValue fact = (FactAddressValue) mv.multifieldValue().get(0);
            intrebarea = fact.getFactSlot("val").toString();
            intrebare.setText(intrebarea);     
        }
        catch(Exception ex){}
    }
        
    public void setare_obiecte_start()
    {
        auxiliar.setText(""); 
        auxiliar.setVisible(false);
        da.setVisible(true); 
        nu.setVisible(true); 
        panou.setVisible(true); 
        labelpanou.setVisible(true); 
        scroll.setVisible(true);
        da.setText("Da"); 
        nu.setText("Nu");
        restart.setVisible(false);
    }
    
    public void returneaza_diagnostic()
    {
        try
        {
            clips.run();           
            MultifieldValue mv = (MultifieldValue) clips.eval("(find-all-facts ((?x boala)) TRUE)");
            FactAddressValue fact = (FactAddressValue) mv.multifieldValue().get(0);            
            String boala = fact.getFactSlot("denumire").toString();
            String coeficient = fact.getFactSlot("cf").toString();            
            String stop;
            stop = semnaleaza_oprire();
            if(stop.equals("da"))
            {
                auxiliar.setVisible(true);
                auxiliar.setText("Rezultatul este: " + boala + " cu un procent de " + coeficient + "%");
                ConexiuneDB.Diagnostic(boala, coeficient, user);
                restart.setText("Vezi mai multe");
                diag.setText(boala);
                recomandare.setText("procent " + coeficient + "%");
                restart.setBounds(230,290,140,30);
                restart.setVisible(true);
                da.setVisible(false);
                nu.setVisible(false);
            }
        }
        catch(Exception ex){}
    }
    
    public String semnaleaza_oprire()
    {
        String stop = "";
        try 
        {            
            clips.run();
            MultifieldValue mv = (MultifieldValue) clips.eval("(find-all-facts ((?y opreste)) TRUE)");
            FactAddressValue fact = (FactAddressValue) mv.multifieldValue().get(0);
            stop = fact.getFactSlot("stop").toString();         
        } 
        catch (Exception ex) {}
        return stop;
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
