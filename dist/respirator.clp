;; #############################
;; ## Definire valori globale ##
;; #############################

(defglobal ?*val-apnee* = 50)
(defglobal ?*val-viroza* = 90)
(defglobal ?*val-bronsita* = 60)
(defglobal ?*val-astm* = 60)
(defglobal ?*val-faringita* = 60)
(defglobal ?*val-gripa* = 90)


;; ######################################
;; ## Definire template-uri respirator ##
;; ######################################

(deftemplate boala
	(slot denumire)
	(slot cf))

(deftemplate intrebari-r
	(slot intrebare)
	(slot id)
	(slot da)
	(slot nu)
	(slot nu2))

(deftemplate intrebare-curenta
	(slot val))

(deftemplate opreste
	(slot stop))
	
(deftemplate ponderi-diagnostic
	(slot nume)
	(slot pondere))
	
(deftemplate ponderi-simptome
	(slot simptom)
	(slot boala)
	(slot pondere))

;; #################################
;; ## Intrebari sistem respirator ##
;; #################################

(deffacts respirator
	(intrebari-r (id 1) (intrebare "Aveti senzatia de tuse?") (da 3) (nu 6))
	(intrebari-r (id 2) (intrebare "Tusea este seaca sau productiva?") (da 28) (nu 5))
	(intrebari-r (id 3) (intrebare "Vi se intampla sa aveti o criza de tuse?")(da 4) (nu 4))
	(intrebari-r (id 4) (intrebare "Aveti dureri in piept in timpul tusei?")(da 2) (nu 2))
	(intrebari-r (id 5) (intrebare "Tusea este insotita de eliminari de sange?")(da 29) (nu 12))
	(intrebari-r (id 6) (intrebare "Sforaiti puternic?")(da 7) (nu 7))
	(intrebari-r (id 7) (intrebare "Pe timpul noptii aveti pierderi necontrolate de urina?")(da 8) (nu 8))
	(intrebari-r (id 8) (intrebare "Transpirati abundent pe parcursul noptii?")(da 9) (nu 9))
	(intrebari-r (id 9) (intrebare "Suferiti de obezitate?")(da 10) (nu 10))
	(intrebari-r (id 10) (intrebare "Aveti tulburari comportamentale?")(da 11) (nu 11))
	(intrebari-r (id 11) (intrebare "Aveti o somnolenta diurna excesiva?")(da 12) (nu 12))
	(intrebari-r (id 12) (intrebare "Aveti febra?")(da 14) (nu 17))
	(intrebari-r (id 13) (intrebare "Febra este usoara (~37), moderata(~38) sau puternica(>38)?")(da 17) (nu 17) (nu2 15))
	(intrebari-r (id 14) (intrebare "Febra este insotita de frisoane?")(da 13) (nu 13))
	(intrebari-r (id 15) (intrebare "Aveti dureri musculare?")(da 17) (nu 17))
	(intrebari-r (id 16) (intrebare "Va simtiti obosit in permanenta?")(da 1) (nu 1))
	(intrebari-r (id 17) (intrebare "V-a disparut pofta de mancare?")(da 18) (nu 18))
	(intrebari-r (id 18) (intrebare "Aveti o stare generala de rau?")(da 19) (nu 19))
	(intrebari-r (id 19) (intrebare "Prezentati secretii nazale?")(da 20) (nu 20))
	(intrebari-r (id 20) (intrebare "Aveti o senzatie de voma?")(da 21) (nu 21))
	(intrebari-r (id 21) (intrebare "Aveti dureri de cap?")(da 22) (nu 22))
	(intrebari-r (id 22) (intrebare "Aveti dureri in gat?")(da 23) (nu 23))
	(intrebari-r (id 23) (intrebare "Prezentati o inrosire vizibila a mucoasei faringiene?")(da 24) (nu 24))
	(intrebari-r (id 24) (intrebare "Intampinati dificultate la inghitire?")(da 25) (nu 25))
	(intrebari-r (id 25) (intrebare "Prezentati o perturbare a simtului olfactiv (a mirosului)?")(da 26) (nu 26))
	(intrebari-r (id 26) (intrebare "Aveti o puternica senzatie de uscaciune in gat?")(da 27) (nu 27))
	(intrebari-r (id 27) (intrebare "Prezentati o inflamare vizibila a ganglionilor?") (da 30) (nu 30))
	(intrebari-r (id 28) (intrebare "Simtiti ca va sufocati?")(da 29) (nu 29))
	(intrebari-r (id 29) (intrebare "Aveti o respiratie suieratoare, zgomotoasa?")(da 30) (nu 30))
	(intrebari-r (id 30) (intrebare "Aveti o oarecare dificultate in respiratie?")(da 31) (nu 31))
	(intrebari-r (id 31) (intrebare "Prezentati dureri in piept la respiratie?")(da 12) (nu 12))
	(intrebari-r (id 32) (intrebare "Diagnosticarea s-a incheiat."))

	(intreaba)
	(id-actual 16)
	(intrebare-curenta))

;; #################################################
;; ## Reguli pentru aplicare intrebari Respirator ##
;; #################################################

(defrule apneenu
	(sforait nu)
	(pierdere-urina nu)
	(or
		(transpiratie-noaptea nu)
		(transpiratie-noaptea da))
	=>
	(assert (stop-apnee)))

(defrule apneestop
	?o <- (stop-apnee)
	?p <- (id-actual ?id)
	(intrebari-r (id 11))
	=>
	(retract ?p)
	(retract ?o)
	(assert (intreaba))
	(assert (id-actual 11)))

(defrule opreste
	(declare (salience 100))
	?p <- (stop)
	?n <- (id-actual ?id)
	(intrebari-r (id 32))
    =>
	(retract ?n)
	(retract ?p)
	(assert (id-actual 32))
	(assert (intreaba))
	(assert (opreste (stop da))))

(defrule pune-intrebare
	?e <- (intreaba)
	?n <- (id-actual ?id)
	?p <- (intrebare-curenta)
	(intrebari-r (id ?id) (intrebare ?val))
	=>
	(retract ?e)
	(retract ?p)
	(assert (intrebare-curenta (val ?val))))

(defrule raspuns-da
	?n <- (id-actual ?id)
	?o <- (raspuns da)
	(intrebari-r (id ?id) (da ?p))
    =>
	(retract ?n)
	(retract ?o)
	(assert (id-actual ?p))
	(assert (intreaba)))

(defrule raspuns-nu
  	?n <- (id-actual ?id)
	?o <- (raspuns nu)
	(intrebari-r (id ?id) (nu ?p))
    =>
	(retract ?n)
	(retract ?o)
	(assert (id-actual ?p))
	(assert (intreaba)))

(defrule raspuns-nu2
  	?n <- (id-actual ?id)
	?o <- (raspuns nu2)
	(intrebari-r (id ?id) (nu2 ?p))
    =>
	(retract ?n)
	(retract ?o)
	(assert (id-actual ?p))
	(assert (intreaba)))

(defrule eliminare-boli-cf-mic
	?f1 <- (boala (denumire ?) (cf ?y1))
	?f2 <- (boala (denumire ?) (cf ?y2))
	(test (> ?y1 ?y2))
	=>
	(retract ?f2))


;; #################################################
;; ## Reguli pentru atribuire simptome Respirator ##
;; #################################################

(defrule tuse-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 1))
	=>
	(assert (tuse da)))

(defrule tuse-nu
	(declare  (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 1))
	=>
	(assert (tuse nu)))

(defrule tuse-seaca
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 2))
	=>
	(assert (tuse-seaca)))

(defrule tuse-productiva
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 2))
	=>
	(assert (tuse-productiva)))

(defrule criza-tuse-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 3))
	=>
	(assert (criza-tuse da)))

(defrule criza-tuse-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 3))
	=>
	(assert (criza-tuse nu)))

(defrule dureri-piept-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 4))
	=>
	(assert (durere-piept-tuse da)))

(defrule dureri-piept-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 4))
	=>
	(assert (durere-piept-tuse nu)))

(defrule tuse-sange-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 5))
	=>
	(assert (tuse-sange da)))

(defrule tuse-sange-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 5))
	=>
	(assert (tuse-sange nu)))

(defrule sforait-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 6))
	=>
	(assert (sforait da)))

(defrule sforait-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 6))
	=>
	(assert (sforait nu)))

(defrule pierdere-urina-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 7))
	=>
	(assert (pierdere-urina da)))

(defrule pierdere-urina-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 7))
	=>
	(assert (pierdere-urina nu)))

(defrule transpiratie-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 8))
	=>
	(assert (transpiratie-noaptea da)))

(defrule transpiratie-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 8))
	=>
	(assert (transpiratie-noaptea nu)))

(defrule obezitate-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 9))
	=>
	(assert (obezitate da)))

(defrule obezitate-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 9))
	=>
	(assert (obezitate nu)))

(defrule tulburari-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 10))
	=>
	(assert (tulburari-comportament da)))

(defrule tulburari-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 10))
	=>
	(assert (tulburari-comportament nu)))

(defrule somnolenta-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 11))
	=>
	(assert (somnolenta-diurna da)))

(defrule somnolenta-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 11))
	=>
	(assert (somnolenta-diurna nu)))

(defrule febra-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 12))
	=>
	(assert (febra da)))

(defrule febra-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 12))
	=>
	(assert (febra nu)))

(defrule febra-usoara
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 13))
	=>
	(assert (febra-usoara)))

(defrule febra-moderata
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 13))
	=>
	(assert (febra-moderata)))

(defrule febra-puternica
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu2)
	(test (eq ?id 13))
	=>
	(assert (febra-puternica)))

(defrule frisoane-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 14))
	=>
	(assert (frisoane da)))

(defrule frisoane-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 14))
	=>
	(assert (frisoane nu)))

(defrule dureri-musc-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 15))
	=>
	(assert (dureri-musculare da)))

(defrule dureri-musc-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 15))
	=>
	(assert (dureri-musculare nu)))

(defrule oboseala-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 16))
	=>
	(assert (oboseala da)))

(defrule oboseala-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 16))
	=>
	(assert (oboseala nu)))

(defrule lipsa-pofta-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 17))
	=>
	(assert (lipsa-pofta-mancare da)))

(defrule lipsa-pofta-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 17))
	=>
	(assert (lipsa-pofta-mancare nu)))

(defrule rau-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 18))
	=>
	(assert (stare-de-rau da)))

(defrule rau-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 18))
	=>
	(assert (stare-de-rau nu)))

(defrule secretii-nazale-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 19))
	=>
	(assert (secretii-nazale da)))

(defrule secretii-nazale-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 19))
	=>
	(assert (secretii-nazale nu)))

(defrule voma-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 20))
	=>
	(assert (voma da)))

(defrule voma-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 20))
	=>
	(assert (voma nu)))

(defrule dureri-cap-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 21))
	=>
	(assert (durere-cap da)))

(defrule dureri-cap-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 21))
	=>
	(assert (durere-cap nu)))

(defrule dureri-gat-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 22))
	=>
	(assert (dureri-gat da)))

(defrule dureri-gat-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 22))
	=>
	(assert (dureri-gat nu)))

(defrule inrosire-faringe-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 23))
	=>
	(assert (inrosire-faringe da)))

(defrule inrosire-faringe-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 23))
	=>
	(assert (inrosire-faringe nu)))

(defrule dificultate-inghitire-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 24))
	=>
	(assert (dificultate-inghitire da)))

(defrule dificultate-inghitire-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 24))
	=>
	(assert (dificultate-inghitire nu)))

(defrule perturbare-miros-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 25))
	=>
	(assert (perturbare-miros da)))

(defrule perturbare-miros-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 25))
	=>
	(assert (perturbare-miros nu)))

(defrule gat-uscat-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 26))
	=>
	(assert (gat-uscat da)))

(defrule gat-uscat-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 26))
	=>
	(assert (gat-uscat nu)))

(defrule ganglioni-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 27))
	=>
	(assert (inflamare-ganglioni da)))

(defrule ganglioni-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 27))
	=>
	(assert (inflamare-ganglioni nu)))

(defrule sufocare-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 28))
	=>
	(assert (sufocare da)))

(defrule sufocare-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 28))
	=>
	(assert (sufocare nu)))

(defrule respiratiezgomotoasa-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 29))
	=>
	(assert (respiratie-zgomotoasa da)))

(defrule respiratiezgomotoasa-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 29))
	=>
	(assert (respiratie-zgomotoasa nu)))

(defrule dificultaterespiratie-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 30))
	=>
	(assert (dificultate-respiratie da)))

(defrule dificultaterespiratie-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 30))
	=>
	(assert (dificultate-respiratie nu)))

(defrule dureripieptresp-da
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns da)
	(test (eq ?id 31))
	=>
	(assert (durere-piept-respiratie da)))

(defrule dureripieptresp-nu
	(declare (salience 99))
	?n <- (id-actual ?id)
	(raspuns nu)
	(test (eq ?id 31))
	=>
	(assert (durere-piept-respiratie nu)))
	
;; #####################################
;; ## Reguli pentru atribuire ponderi ##
;; #####################################

(defrule p0
	(or (tuse-productiva)
		(tuse-seaca))
	=>
	(assert (ponderi-simptome(simptom tuse-da)(boala Astm-Bronsic)(pondere 8)))
	(assert (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere 8)))
	(assert (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere 10))))

(defrule p1
	(tuse da)
	(tuse-seaca)
	=>
	(assert (ponderi-simptome(simptom tuse-seaca-da)(boala Faringita)(pondere 8))))
	
(defrule p2
	(tuse da)
	(tuse-productiva)
	=>
	(assert (ponderi-simptome(simptom tuse-productiva-da)(boala Bronsita)(pondere 6))))
	
(defrule p3
	(tuse nu)
	=>
	(assert (ponderi-simptome(simptom tuse-nu)(boala Apnee-Obstructiva)(pondere 0)))
	(assert (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere 1))))
	
(defrule p4
	(sforait da)
	=>
	(assert (ponderi-simptome(simptom sforait-da)(boala Apnee-Obstructiva)(pondere 10))))
	
(defrule p5
	(obezitate da)
	=>
	(assert (ponderi-simptome(simptom obezitate-da)(boala Apnee-Obstructiva)(pondere 10))))
	
(defrule p6
	(pierdere-urina da)
	=>
	(assert (ponderi-simptome(simptom pierdere-urina-da)(boala Apnee-Obstructiva)(pondere 9))))
	
(defrule p7
	(tulburari-comportament da)
	=>
	(assert (ponderi-simptome(simptom tulburari-comportament-da)(boala Apnee-Obstructiva)(pondere 7))))
	
(defrule p8
	(somnolenta-diurna da)
	=>
	(assert (ponderi-simptome(simptom somnolenta-diurna-da)(boala Apnee-Obstructiva)(pondere 9))))
	
(defrule p9
	(transpiratie-noaptea da)
	=>
	(assert (ponderi-simptome(simptom transpiratie-noaptea-da)(boala Apnee-Obstructiva)(pondere 5))))
	
(defrule p10
	(durere-piept-respiratie da)
	=>
	(assert (ponderi-simptome(simptom durere-piept-respiratie-da)(boala Bronsita)(pondere 8)))
	(assert (ponderi-simptome(simptom durere-piept-respiratie-da)(boala Astm-Bronsic)(pondere 7))))
	
(defrule p11
	(durere-piept-tuse da)
	=>
	(assert (ponderi-simptome(simptom durere-piept-tuse-da)(boala Bronsita)(pondere 8)))
	(assert (ponderi-simptome(simptom durere-piept-tuse-da)(boala Astm-Bronsic)(pondere 7))))
	
(defrule p12
	(criza-tuse da)
	=>
	(assert (ponderi-simptome(simptom criza-tuse-da)(boala Astm-Bronsic)(pondere 9))))
	
(defrule p13
	(respiratie-zgomotoasa da)
	=>
	(assert (ponderi-simptome(simptom respiratie-zgomotoasa-da)(boala Bronsita)(pondere 8)))
	(assert (ponderi-simptome(simptom respiratie-zgomotoasa-da)(boala Astm-Bronsic)(pondere 10))))
	
(defrule p14
	(dificultate-respiratie da)
	=>
	(assert (ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere 5)))
	(assert (ponderi-simptome(simptom dificultate-respiratie-da)(boala Bronsita)(pondere 7)))
	(assert (ponderi-simptome(simptom dificultate-respiratie-da)(boala Astm-Bronsic)(pondere 9))))
	
(defrule p15
	(sufocare da)
	=>
	(assert (ponderi-simptome(simptom sufocare-da)(boala Astm-Bronsic)(pondere 10))))
	
(defrule p16
	(febra da)
	(febra-moderata)
	=>
	(assert (ponderi-simptome(simptom febra-moderata-da)(boala Bronsita)(pondere 6))))
	
(defrule p17
	(febra da)
	=>
	(assert (ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere 9))))
	
(defrule p18
	(tuse-sange da)
	=>
	(assert (ponderi-simptome(simptom tuse-sange-da)(boala Bronsita)(pondere 10))))
	
(defrule p19
	(oboseala da)
	=>
	(assert (ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere 6)))
	(assert (ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere 8)))
	(assert (ponderi-simptome(simptom oboseala-da)(boala Bronsita)(pondere 7))))
	
(defrule p20
	(febra da)
	(febra-puternica)
	=>
	(assert (ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere 10))))
	
(defrule p21
	(dureri-musculare da)
	=>
	(assert (ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere 9))))
	
(defrule p22
	(stare-de-rau da)
	=>
	(assert (ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere 9))))
	
(defrule p23
	(durere-cap da)
	=>
	(assert (ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere 5)))
	(assert (ponderi-simptome(simptom durere-cap-da)(boala Gripa)(pondere 8))))
	
(defrule p24
	(frisoane da)
	=>
	(assert (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere 5)))
	(assert (ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere 10))))
	
(defrule p25
	(inflamare-ganglioni da)
	=>
	(assert (ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere 5)))
	(assert (ponderi-simptome(simptom inflamare-ganglioni-da)(boala Faringita)(pondere 10)))
	(assert (ponderi-simptome(simptom inflamare-ganglioni-da)(boala Gripa)(pondere 5))))
	
(defrule p26
	(voma da)
	=>
	(assert (ponderi-simptome(simptom voma-da)(boala Gripa)(pondere 10))))
	
(defrule p27
	(lipsa-pofta-mancare da)
	=>
	(assert (ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere 9)))
	(assert (ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Gripa)(pondere 6))))
	
(defrule p28
	(secretii-nazale da)
	=>
	(assert (ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere 8)))
	(assert (ponderi-simptome(simptom secretii-nazale-da)(boala Gripa)(pondere 7))))
	
(defrule p29
	(febra da)
	(febra-usoara)
	=>
	(assert (ponderi-simptome(simptom febra-usoara-da)(boala Faringita)(pondere 7))))
	
(defrule p30
	(dureri-gat da)
	=>
	(assert (ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere 6)))
	(assert (ponderi-simptome(simptom dureri-gat-da)(boala Faringita)(pondere 10))))
	
(defrule p31
	(dificultate-inghitire da)
	=>
	(assert (ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere 7)))
	(assert (ponderi-simptome(simptom dificultate-inghitire-da)(boala Faringita)(pondere 7))))
	
(defrule p32
	(gat-uscat da)
	=>
	(assert (ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere 7)))
	(assert (ponderi-simptome(simptom gat-uscat-da)(boala Faringita)(pondere 8))))
	
(defrule p33
	(inrosire-faringe da)
	=>
	(assert (ponderi-simptome(simptom inrosire-faringe-da)(boala Faringita)(pondere 10))))
	
(defrule p34
	(perturbare-miros da)
	=>
	(assert (ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere 8))))
	
(defrule p35
	(sforait nu)
	=>
	(assert (ponderi-simptome(simptom sforait-nu)(boala Apnee-Obstructiva)(pondere 0))))
	
(defrule p36
	(obezitate nu)
	=>
	(assert (ponderi-simptome(simptom obezitate-nu)(boala Apnee-Obstructiva)(pondere 0))))
	
(defrule p37
	(pierdere-urina nu)
	=>
	(assert (ponderi-simptome(simptom pierdere-urina-nu)(boala Apnee-Obstructiva)(pondere 0))))
	
(defrule p38
	(tulburari-comportament nu)
	=>
	(assert (ponderi-simptome(simptom tulburari-comportament-nu)(boala Apnee-Obstructiva)(pondere 0))))
	
(defrule p39
	(somnolenta-diurna nu)
	=>
	(assert (ponderi-simptome(simptom somnolenta-diurna-nu)(boala Apnee-Obstructiva)(pondere 0))))
	
(defrule p40
	(transpiratie-noaptea nu)
	=>
	(assert (ponderi-simptome(simptom transpiratie-noaptea-nu)(boala Apnee-Obstructiva)(pondere 0))))
	
(defrule p41
	(durere-piept-respiratie nu)
	=>
	(assert (ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Bronsita)(pondere 0)))
	(assert (ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Astm-Bronsic)(pondere 0))))
	
(defrule p42
	(durere-piept-tuse nu)
	=>
	(assert (ponderi-simptome(simptom durere-piept-tuse-nu)(boala Bronsita)(pondere 0)))
	(assert (ponderi-simptome(simptom durere-piept-tuse-nu)(boala Astm-Bronsic)(pondere 0))))
	
(defrule p43
	(criza-tuse nu)
	=>
	(assert (ponderi-simptome(simptom criza-tuse-nu)(boala Astm-Bronsic)(pondere 0))))
	
(defrule p44
	(respiratie-zgomotoasa nu)
	=>
	(assert (ponderi-simptome(simptom respiratie-zgomotoasa-nu)(boala Bronsita)(pondere 0)))
	(assert (ponderi-simptome(simptom respiratie-zgomotoasa-nu)(boala Astm-Bronsic)(pondere 0))))
	
(defrule p45
	(dificultate-respiratie nu)
	=>
	(assert (ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom dificultate-respiratie-nu)(boala Bronsita)(pondere 0)))
	(assert (ponderi-simptome(simptom dificultate-respiratie-nu)(boala Astm-Bronsic)(pondere 0))))
	
(defrule p46
	(sufocare nu)
	=>
	(assert (ponderi-simptome(simptom sufocare-nu)(boala Astm-Bronsic)(pondere 0))))
	
(defrule p47
	(febra nu)
	=>
	(assert (ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere 0))))
	
(defrule p48
	(tuse-sange nu)
	=>
	(assert (ponderi-simptome(simptom tuse-sange-nu)(boala Bronsita)(pondere 0))))
	
(defrule p49
	(oboseala nu)
	=>
	(assert (ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere 0)))
	(assert (ponderi-simptome(simptom oboseala-nu)(boala Bronsita)(pondere 0))))
	
(defrule p50
	(dureri-musculare nu)
	=>
	(assert (ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere 0))))
	
(defrule p51
	(stare-de-rau nu)
	=>
	(assert (ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere 0))))
	
(defrule p52
	(durere-cap nu)
	=>
	(assert (ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom durere-cap-nu)(boala Gripa)(pondere 0))))
	
(defrule p53
	(frisoane nu)
	=>
	(assert (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere 0))))
	
(defrule p54
	(inflamare-ganglioni nu)
	=>
	(assert (ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Faringita)(pondere 0)))
	(assert (ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Gripa)(pondere 0))))
	
(defrule p55
	(voma nu)
	=>
	(assert (ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere 0))))
	
(defrule p56
	(lipsa-pofta-mancare nu)
	=>
	(assert (ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Gripa)(pondere 0))))
	
(defrule p57
	(secretii-nazale nu)
	=>
	(assert (ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom secretii-nazale-nu)(boala Gripa)(pondere 0))))
	
(defrule p58
	(dureri-gat nu)
	=>
	(assert (ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom dureri-gat-nu)(boala Faringita)(pondere 0))))
	
(defrule p59
	(dificultate-inghitire nu)
	=>
	(assert (ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom dificultate-inghitire-nu)(boala Faringita)(pondere 0))))
	
(defrule p60
	(gat-uscat nu)
	=>
	(assert (ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere 0)))
	(assert (ponderi-simptome(simptom gat-uscat-nu)(boala Faringita)(pondere 0))))
	
(defrule p61
	(inrosire-faringe nu)
	=>
	(assert (ponderi-simptome(simptom inrosire-faringe-nu)(boala Faringita)(pondere 0))))
	
(defrule p62
	(perturbare-miros nu)
	=>
	(assert (ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere 0))))

;; ############################################
;; ## Reguli pentru diagnosticare Respirator ##
;; ############################################


;; ######################
;; #### Reguli Apnee ####
;; ######################

(defrule r4
	(ponderi-simptome(simptom tuse-nu)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom sforait-da)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom pierdere-urina-da)(boala Apnee-Obstructiva)(pondere ?c))
	(ponderi-simptome(simptom transpiratie-noaptea-nu)(boala Apnee-Obstructiva)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Apnee) (pondere (+ ?a ?b ?c ?d)))))

(defrule r5
	(ponderi-simptome(simptom tuse-nu)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom sforait-nu)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom pierdere-urina-da)(boala Apnee-Obstructiva)(pondere ?c))
	(ponderi-simptome(simptom transpiratie-noaptea-da)(boala Apnee-Obstructiva)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Apnee) (pondere (+ ?a ?b ?c ?d)))))

(defrule r6
	(ponderi-simptome(simptom tuse-nu)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom sforait-da)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom pierdere-urina-nu)(boala Apnee-Obstructiva)(pondere ?c))
	(ponderi-simptome(simptom transpiratie-noaptea-da)(boala Apnee-Obstructiva)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Apnee) (pondere (+ ?a ?b ?c ?d)))))

(defrule r7
	(ponderi-simptome(simptom tuse-nu)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom sforait-da)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom pierdere-urina-da)(boala Apnee-Obstructiva)(pondere ?c))
	(ponderi-simptome(simptom transpiratie-noaptea-da)(boala Apnee-Obstructiva)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Apnee) (pondere (+ ?a ?b ?c ?d)))))

(defrule r8
	(ponderi-simptome(simptom obezitate-nu)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom tulburari-comportament-nu)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom somnolenta-diurna-nu)(boala Apnee-Obstructiva)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Apnee+) (pondere (+ ?a ?b ?c)))))

(defrule r9
	(ponderi-simptome(simptom obezitate-da)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom tulburari-comportament-da)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom somnolenta-diurna-da)(boala Apnee-Obstructiva)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Apnee+) (pondere (+ ?a ?b ?c)))))

(defrule r10
	(ponderi-simptome(simptom obezitate-nu)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom tulburari-comportament-da)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom somnolenta-diurna-da)(boala Apnee-Obstructiva)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Apnee+) (pondere (+ ?a ?b ?c)))))

(defrule r11
	(ponderi-simptome(simptom obezitate-da)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom tulburari-comportament-nu)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom somnolenta-diurna-da)(boala Apnee-Obstructiva)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Apnee+) (pondere (+ ?a ?b ?c)))))

(defrule r12
	(ponderi-simptome(simptom obezitate-da)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom tulburari-comportament-da)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom somnolenta-diurna-nu)(boala Apnee-Obstructiva)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Apnee+) (pondere (+ ?a ?b ?c)))))

(defrule r13
	(ponderi-simptome(simptom obezitate-nu)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom tulburari-comportament-nu)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom somnolenta-diurna-da)(boala Apnee-Obstructiva)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Apnee+) (pondere (+ ?a ?b ?c)))))

(defrule r14
	(ponderi-simptome(simptom obezitate-da)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom tulburari-comportament-nu)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom somnolenta-diurna-nu)(boala Apnee-Obstructiva)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Apnee+) (pondere (+ ?a ?b ?c)))))

(defrule r15
	(ponderi-simptome(simptom obezitate-nu)(boala Apnee-Obstructiva)(pondere ?a))
	(ponderi-simptome(simptom tulburari-comportament-da)(boala Apnee-Obstructiva)(pondere ?b))
	(ponderi-simptome(simptom somnolenta-diurna-nu)(boala Apnee-Obstructiva)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Apnee+) (pondere (+ ?a ?b ?c)))))

(defrule r16
	(ponderi-diagnostic (nume Apnee) (pondere ?p1))
	(ponderi-diagnostic (nume Apnee+) (pondere ?p2))
	(test (> (integer (* (/ (+ ?p1 ?p2) ?*val-apnee*) 100)) 30))
	=>
	(assert (stop))
	(assert (boala (denumire Apnee-Obstructiva) (cf (integer (* (/ (+ ?p1 ?p2) ?*val-apnee*) 100))))))

;; #####################
;; #### Reguli Astm ####
;; #####################

(defrule r17
	(ponderi-simptome(simptom tuse-da)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom sufocare-da)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom respiratie-zgomotoasa-da)(boala Astm-Bronsic)(pondere ?c))
	(ponderi-simptome(simptom criza-tuse-nu)(boala Astm-Bronsic)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Astm) (pondere (+ ?a ?b ?c ?d)))))

(defrule r18
	(ponderi-simptome(simptom tuse-da)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom sufocare-da)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom respiratie-zgomotoasa-da)(boala Astm-Bronsic)(pondere ?c))
	(ponderi-simptome(simptom criza-tuse-da)(boala Astm-Bronsic)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Astm) (pondere (+ ?a ?b ?c ?d)))))

(defrule r19
	(ponderi-simptome(simptom tuse-da)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom sufocare-da)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom respiratie-zgomotoasa-nu)(boala Astm-Bronsic)(pondere ?c))
	(ponderi-simptome(simptom criza-tuse-da)(boala Astm-Bronsic)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Astm) (pondere (+ ?a ?b ?c ?d)))))

(defrule r20
	(ponderi-simptome(simptom tuse-da)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom sufocare-nu)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom respiratie-zgomotoasa-da)(boala Astm-Bronsic)(pondere ?c))
	(ponderi-simptome(simptom criza-tuse-da)(boala Astm-Bronsic)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Astm) (pondere (+ ?a ?b ?c ?d)))))

(defrule r21
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-tuse-nu)(boala Astm-Bronsic)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Astm+) (pondere (+ ?a ?b ?c)))))

(defrule r22
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-tuse-nu)(boala Astm-Bronsic)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Astm+) (pondere (+ ?a ?b ?c)))))

(defrule r23
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom durere-piept-respiratie-da)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-tuse-nu)(boala Astm-Bronsic)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Astm+) (pondere (+ ?a ?b ?c)))))

(defrule r24
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-tuse-da)(boala Astm-Bronsic)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Astm+) (pondere (+ ?a ?b ?c)))))

(defrule r25
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom durere-piept-respiratie-da)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-tuse-nu)(boala Astm-Bronsic)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Astm+) (pondere (+ ?a ?b ?c)))))

(defrule r26
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom durere-piept-respiratie-da)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-tuse-da)(boala Astm-Bronsic)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Astm+) (pondere (+ ?a ?b ?c)))))

(defrule r27
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-tuse-da)(boala Astm-Bronsic)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Astm+) (pondere (+ ?a ?b ?c)))))

(defrule r28
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Astm-Bronsic)(pondere ?a))
	(ponderi-simptome(simptom durere-piept-respiratie-da)(boala Astm-Bronsic)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-tuse-da)(boala Astm-Bronsic)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Astm+) (pondere (+ ?a ?b ?c)))))

(defrule r29
	(ponderi-diagnostic (nume Astm) (pondere ?p1))
	(ponderi-diagnostic (nume Astm+) (pondere ?p2))
	(test (> (integer (* (/ (+ ?p1 ?p2) ?*val-astm*) 100)) 30))
	=>
	(assert (stop))
	(assert (boala (denumire Astm-Bronsic) (cf (integer (* (/ (+ ?p1 ?p2) ?*val-astm*) 100))))))


;; #########################
;; #### Reguli Bronsita ####
;; #########################

(defrule r30
	(ponderi-simptome(simptom tuse-productiva-da)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom febra-moderata-da)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom tuse-sange-da)(boala Bronsita)(pondere ?c))
	(ponderi-simptome(simptom respiratie-zgomotoasa-da)(boala Bronsita)(pondere ?d))
	(ponderi-simptome(simptom oboseala-da)(boala Bronsita)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Bronsita) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r31
	(ponderi-simptome(simptom tuse-productiva-da)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom febra-moderata-da)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom tuse-sange-da)(boala Bronsita)(pondere ?c))
	(ponderi-simptome(simptom respiratie-zgomotoasa-nu)(boala Bronsita)(pondere ?d))
	(ponderi-simptome(simptom oboseala-da)(boala Bronsita)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Bronsita) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r32
	(ponderi-simptome(simptom tuse-productiva-da)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom febra-moderata-da)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom tuse-sange-da)(boala Bronsita)(pondere ?c))
	(ponderi-simptome(simptom respiratie-zgomotoasa-da)(boala Bronsita)(pondere ?d))
	(ponderi-simptome(simptom oboseala-nu)(boala Bronsita)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Bronsita) (pondere (+ ?a ?b ?c ?d ?e)))))
	
(defrule r218
	(ponderi-simptome(simptom tuse-productiva-da)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom febra-moderata-da)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom tuse-sange-da)(boala Bronsita)(pondere ?c))
	(ponderi-simptome(simptom respiratie-zgomotoasa-nu)(boala Bronsita)(pondere ?d))
	(ponderi-simptome(simptom oboseala-nu)(boala Bronsita)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Bronsita) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r33
	(ponderi-simptome(simptom durere-piept-tuse-nu)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Bronsita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Bronsita+) (pondere (+ ?a ?b ?c)))))

(defrule r34
	(ponderi-simptome(simptom durere-piept-tuse-da)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-respiratie-da)(boala Bronsita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Bronsita+) (pondere (+ ?a ?b ?c)))))

(defrule r35
	(ponderi-simptome(simptom durere-piept-tuse-da)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Bronsita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Bronsita+) (pondere (+ ?a ?b ?c)))))

(defrule r36
	(ponderi-simptome(simptom durere-piept-tuse-nu)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Bronsita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Bronsita+) (pondere (+ ?a ?b ?c)))))

(defrule r37
	(ponderi-simptome(simptom durere-piept-tuse-nu)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-respiratie-da)(boala Bronsita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Bronsita+) (pondere (+ ?a ?b ?c)))))

(defrule r38
	(ponderi-simptome(simptom durere-piept-tuse-da)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-respiratie-nu)(boala Bronsita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Bronsita+) (pondere (+ ?a ?b ?c)))))

(defrule r39
	(ponderi-simptome(simptom durere-piept-tuse-da)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-respiratie-da)(boala Bronsita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Bronsita+) (pondere (+ ?a ?b ?c)))))

(defrule r40
	(ponderi-simptome(simptom durere-piept-tuse-nu)(boala Bronsita)(pondere ?a))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Bronsita)(pondere ?b))
	(ponderi-simptome(simptom durere-piept-respiratie-da)(boala Bronsita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Bronsita+) (pondere (+ ?a ?b ?c)))))

(defrule r41
	(ponderi-diagnostic (nume Bronsita) (pondere ?p1))
	(ponderi-diagnostic (nume Bronsita+) (pondere ?p2))
	(test (> (integer (* (/ (+ ?p1 ?p2) ?*val-bronsita*) 100)) 30))
	=>
	(assert (stop))
	(assert (boala (denumire Bronsita) (cf (integer (* (/ (+ ?p1 ?p2) ?*val-bronsita*) 100))))))


;; ##########################
;; #### Reguli Faringita ####
;; ##########################

(defrule r42
	(ponderi-simptome(simptom tuse-seaca-da)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom febra-usoara-da)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inrosire-faringe-da)(boala Faringita)(pondere ?c))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Faringita)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Faringita) (pondere (+ ?a ?b ?c ?d)))))

(defrule r43
	(ponderi-simptome(simptom tuse-seaca-da)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom febra-usoara-da)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inrosire-faringe-da)(boala Faringita)(pondere ?c))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Faringita)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Faringita) (pondere (+ ?a ?b ?c ?d)))))

(defrule r44
	(ponderi-simptome(simptom dureri-gat-nu)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Faringita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Faringita+) (pondere (+ ?a ?b ?c)))))

(defrule r45
	(ponderi-simptome(simptom dureri-gat-da)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom gat-uscat-da)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Faringita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Faringita+) (pondere (+ ?a ?b ?c)))))

(defrule r46
	(ponderi-simptome(simptom dureri-gat-da)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Faringita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Faringita+) (pondere (+ ?a ?b ?c)))))

(defrule r47
	(ponderi-simptome(simptom dureri-gat-nu)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom gat-uscat-da)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Faringita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Faringita+) (pondere (+ ?a ?b ?c)))))

(defrule r48
	(ponderi-simptome(simptom dureri-gat-nu)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Faringita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Faringita+) (pondere (+ ?a ?b ?c)))))

(defrule r49
	(ponderi-simptome(simptom dureri-gat-nu)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom gat-uscat-da)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Faringita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Faringita+) (pondere (+ ?a ?b ?c)))))

(defrule r50
	(ponderi-simptome(simptom dureri-gat-da)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom gat-uscat-da)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Faringita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Faringita+) (pondere (+ ?a ?b ?c)))))

(defrule r51
	(ponderi-simptome(simptom dureri-gat-da)(boala Faringita)(pondere ?a))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Faringita)(pondere ?b))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Faringita)(pondere ?c))
	=>
	(assert (ponderi-diagnostic (nume Faringita+) (pondere (+ ?a ?b ?c)))))

(defrule r52
	(ponderi-diagnostic (nume Faringita) (pondere ?p1))
	(ponderi-diagnostic (nume Faringita+) (pondere ?p2))
	(test (> (integer (* (/ (+ ?p1 ?p2) ?*val-faringita*) 100)) 30))
	=>
	(assert (stop))
	(assert (boala (denumire Faringita) (cf (integer (* (/ (+ ?p1 ?p2) ?*val-faringita*) 100))))))

;; ######################
;; #### Reguli Gripa ####
;; ######################

(defrule r53
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r54
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r55
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r56
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r57
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r58
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r59
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r60
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r61
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r62
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r63
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r64
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r65
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r66
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r67
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r68
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r69
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r70
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r71
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r72
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r73
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r74
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r75
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r76
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r77
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r78
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r79
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-da)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r80
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-da)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r81
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-da)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r82
	(or (ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-da)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r83
	(ponderi-simptome(simptom durere-cap-nu)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r84
	(ponderi-simptome(simptom durere-cap-da)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r85
	(ponderi-simptome(simptom durere-cap-da)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r86
	(ponderi-simptome(simptom durere-cap-da)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r87
	(ponderi-simptome(simptom durere-cap-da)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r89
	(ponderi-simptome(simptom durere-cap-nu)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r91
	(ponderi-simptome(simptom durere-cap-nu)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r92
	(ponderi-simptome(simptom durere-cap-nu)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r93
	(ponderi-simptome(simptom durere-cap-nu)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r94
	(ponderi-simptome(simptom durere-cap-da)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r95
	(ponderi-simptome(simptom durere-cap-da)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r96
	(ponderi-simptome(simptom durere-cap-da)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r100
	(ponderi-simptome(simptom durere-cap-da)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))


(defrule r104
	(ponderi-simptome(simptom durere-cap-nu)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r105
	(ponderi-simptome(simptom durere-cap-nu)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r106
	(ponderi-simptome(simptom durere-cap-nu)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Gripa)(pondere ?d))
	=>
	(assert (ponderi-diagnostic (nume Gripa+) (pondere (+ ?a ?b ?c ?d)))))

(defrule r114
	(ponderi-simptome(simptom tuse-da)(boala Gripa)(pondere ?a))
	(ponderi-simptome(simptom febra-puternica-da)(boala Gripa)(pondere ?b))
	(ponderi-simptome(simptom frisoane-nu)(boala Gripa)(pondere ?c))
	(ponderi-simptome(simptom oboseala-nu)(boala Gripa)(pondere ?d))
	(ponderi-simptome(simptom stare-de-rau-nu)(boala Gripa)(pondere ?e))
	(ponderi-simptome(simptom dureri-musculare-nu)(boala Gripa)(pondere ?f))
	(ponderi-simptome(simptom voma-nu)(boala Gripa)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Gripa) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r115
	(ponderi-diagnostic (nume Gripa) (pondere ?p1))
	(ponderi-diagnostic (nume Gripa+) (pondere ?p2))
	(test (> (integer (* (/ (+ ?p1 ?p2) ?*val-gripa*) 100)) 30))
	=>
	(assert (stop))
	(assert (boala (denumire Gripa) (cf (integer (* (/ (+ ?p1 ?p2) ?*val-gripa*) 100))))))


;; #######################
;; #### Reguli Viroza ####
;; #######################

(defrule r116
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r117
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r118
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r119
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r120
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r121
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r122
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r123
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r124
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r125
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r126
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r127
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r128
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r129
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r130
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r131
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r132
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r133
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r134
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r135
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r136
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r137
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r138
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r139
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r140
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r141
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r142
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r143
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r144
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r145
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r146
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r147
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r148
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r149
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r150
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r151
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r152
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r153
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r154
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r155
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r156
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r157
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r158
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r159
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r160
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r161
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r162
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r163
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r164
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r165
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r166
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r167
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r168
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r169
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r170
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r171
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r172
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r173
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r174
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-da)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r175
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r176
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r177
	(ponderi-simptome(simptom oboseala-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-da)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r178
	(ponderi-simptome(simptom oboseala-da)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom dificultate-inghitire-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom gat-uscat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom inflamare-ganglioni-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom dificultate-respiratie-nu)(boala Viroza-Respiratorie)(pondere ?e))
	=>
	(assert (ponderi-diagnostic (nume Viroza+) (pondere (+ ?a ?b ?c ?d ?e)))))

(defrule r179
	(ponderi-diagnostic (nume Viroza) (pondere ?p1))
	(ponderi-diagnostic (nume Viroza+) (pondere ?p2))
	=>
	(assert (stop))
	(assert (boala (denumire Viroza-Respiratorie) (cf (integer (* (/ (+ ?p1 ?p2) ?*val-viroza*) 100))))))

(defrule r180
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r181
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r182
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r183
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r184
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r185
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r186
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r187
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r188
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r189
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r190
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r191
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r192
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r193
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r194
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r195
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r196
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r197
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r198
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r199
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r200
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r201
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r202
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r203
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r204
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r205
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r206
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r207
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r208
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r209
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-da)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r210
	(or (ponderi-simptome(simptom tuse-da)(boala Viroza-Respiratorie)(pondere ?a)) (ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a)))
	(ponderi-simptome(simptom febra-da)(boala Viroza-Respiratorie)(pondere ?h))
	(or (ponderi-simptome(simptom frisoane-nu)(boala Viroza-Respiratorie)(pondere ?b)) (ponderi-simptome(simptom frisoane-da)(boala Viroza-Respiratorie)(pondere ?b)))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-da)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-da)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-da)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-da)(boala Viroza-Respiratorie)(pondere ?g))
	=>
	(assert (ponderi-diagnostic (nume Viroza++) (pondere (+ ?a ?b ?c ?d ?e ?f ?g)))))

(defrule r211
	(ponderi-diagnostic (nume Viroza++) (pondere ?p1))
	(ponderi-diagnostic (nume Viroza+) (pondere ?p2))
	=>
	(assert (stop))
	(assert (boala (denumire Viroza-Respiratorie) (cf (integer (* (/ (+ ?p1 ?p2) ?*val-viroza*) 100))))))

(defrule r212
	(ponderi-simptome(simptom tuse-nu)(boala Viroza-Respiratorie)(pondere ?a))
	(ponderi-simptome(simptom febra-nu)(boala Viroza-Respiratorie)(pondere ?b))
	(ponderi-simptome(simptom dureri-gat-nu)(boala Viroza-Respiratorie)(pondere ?c))
	(ponderi-simptome(simptom durere-cap-nu)(boala Viroza-Respiratorie)(pondere ?d))
	(ponderi-simptome(simptom secretii-nazale-nu)(boala Viroza-Respiratorie)(pondere ?e))
	(ponderi-simptome(simptom perturbare-miros-nu)(boala Viroza-Respiratorie)(pondere ?f))
	(ponderi-simptome(simptom lipsa-pofta-mancare-nu)(boala Viroza-Respiratorie)(pondere ?g))
	(ponderi-diagnostic (nume Viroza+) (pondere ?h))
	=>
	(assert (stop))
	(assert (boala (denumire Viroza-Respiratorie) (cf (integer (* (/ (+ ?a ?b ?c ?d ?e ?f ?g ?h) ?*val-viroza*) 100))))))
	
(defrule r213
	(oboseala nu)
	(tuse nu)
	(sforait nu)
	(pierdere-urina nu)
	(transpiratie-noaptea nu)
	(febra nu)
	(lipsa-pofta-mancare nu)
	(stare-de-rau nu)
	(secretii-nazale nu)
	(voma nu)
	(durere-cap nu)
	(dureri-gat nu)
	(inrosire-faringe nu)
	(dificultate-inghitire nu)
	(perturbare-miros nu)
	(gat-uscat nu)
	(inflamare-ganglioni nu)
	(dificultate-respiratie nu)
	=>
	(assert (stop))
	(assert (boala (denumire Sanatos) (cf 100))))