
      SUBROUTINE TAB53A(RHO,DEGC,IHYDRO,RHO15,IFLAG)
      
      double precision RHO, DEGC, RHO15
      integer IHYDRO, IFLAG
      
      DATA IBASE/1500/
      DATA LIM1,LIM2/1074982,610627/
      DATA IBP1,IBP2/77850,82400/
      
      DATA ITMP1,ITMP2,ITMP3 /9500,12500,15000/
      
      DATA IEP1, IEP2, IEP3/6000, 9000, 12000/
      
      DATA IERHO/75800/
      
      DATA K0, K1/6139723, 0/
      
      
      NOUT=6
      
      IRHO=((RHO*100)+25) / 50
      IRHO=IRHO*50
      RHO=FLOAT(IRHO)/100.
      
      IF(DEGC+18)900, 10, 10
      
 10   IRD=25
      IF(DEGC)15,20,20
 15   IRD=-25
 20   IT=((DEGC*1000)+IRD)/50
      IT=IT*5
      DEGC=FLOAT(IT)/100.
      
      
      IF(IRHO-61050)900,40,40
 40   IF(IRHO-107500)50,50,900
 50   IF(IRHO-IBP1)60,60,70
 60   IF(IT-ITMP1)100,100,900
 70   IF(IRHO-IBP2)80,80,90
 80   IF(IT-ITMP2)100,100,900
 90   IF(IT-ITMP3)100,100,900
 100  CONTINUE
      
      IFLAG=0
      IDT=IT-IBASE
      IRHOT=IRHO
      
      IF(IHYDRO)101,101,140
      
 101  IRD=5
      IF(IDT)105,110,110
 105  IRD=-5
 110  IH1=(2300*IDT+IRD)/10
      IH2=(2*IDT*IDT+500)/1000
      IHYC=1000000000 - IH1 - IH2
      
      IRD=IRHO*10
      CALL MPY53A(IRD,IHYC,IRHOT,10000)
      IRHOT=(IRHOT+50)/100
      
 140  JRHOT=IRHOT*10000
      
      IRHO15=IRHOT
      KRHO=0
      NP=0
 300  NP=NP+1
      CALL ALF53A(IRHO15,K0,K1,IALF)
      CALL VCF53A(IALF,IDT,IVCF)
      IVCF=(IVCF+50)/100
      CALL DIV53A(JRHOT,IVCF,IRHO15,1000)
      
      IF(IABS(IRHO15-KRHO)-50)500,320,320
      
 320  KRHO=IRHO15
      IRHO15=(IRHO15+5)/10
      IF(NP-20)300,400,400
      
 400  IFLAG=-1
      RHO15=-999.9
      WRITE(NOUT,6001)DEGC,RHO
 6001 FORMAT(5H0 AT ,F6.2,15H DEGREES C AND ,F7.1,   70H KG/CU METRE, A
     &CORRESPONDING DENSITY AT 15 C COULD NOT BE DETERMINED.)
      
      RETURN
      
 500  IF (IRHO15-LIM1)510,510,900
 510  IF(IRHO15-LIM2)900,520,520
      
 520  JRHOT=(IRHO15 + 50) / 100
      RHO15=FLOAT(JRHOT)/10.
      
      IF (IRHO - IERHO)760,760,770
 760  IFLAG=1
      RETURN
      

 770  IF(IRHO-IBP1)780,780,790
 780  IF(IT-IEP1)820,820,760
 790  IF(IRHO-IBP2)800,800,810
 800  IF(IT-IEP2)820,820,760
 810  IF(IT-IEP3)820,820,760
 820  CONTINUE
      RETURN
      
 900  IFLAG=-1
      RHO15=-999.9
      RETURN
      END
      
      
      SUBROUTINE DIV53A(INUM,IDENOM,IRES,ISCALE)
      
      
      IRES1=INUM/IDENOM
      IRES2=(INUM-IRES1*IDENOM)*ISCALE/IDENOM
      
      IRES=IRES1*ISCALE+IRES2
      RETURN
      END
      
      
      SUBROUTINE ALF53A(IRHO,K0,K1,IALF)
      INUM=K1*10000
      CALL DIV53A(INUM,IRHO,IALF1,10000)
      
      INUM=K0*100
      CALL DIV53A(INUM,IRHO,IALFS,10000)
      CALL DIV53A(IALFS,IRHO,IALF2,10000)
      IALF=(IALF1+IALF2+500)/1000
      RETURN
      END
      
      
      
      SUBROUTINE VCF53A(IALF,IDT,IVCF)
      
      ITERM1=IALF*IDT
      ITERM2=ITERM1/5*4
      
      CALL MPY53A(ITERM1,ITERM2,ITERM3,10000)
      ITERM3=ITERM1 + (ITERM3+5)/10
      IX=-ITERM3/10
      
      ISUM1=100000000+IX
      CALL MPY53A(IX,IX,ISUM2,1000)
      ISUM2=((ISUM2+50)/100)/2
      CALL MPY53A(IX,ISUM2,ISUM3,1000)
      ISUM3=((ISUM3+50)/100)/3
      CALL MPY53A(IX,ISUM3,ISUM4,1000)
      ISUM4=((ISUM4+50)/100)/4
      CALL MPY53A(IX,ISUM4,ISUM5,1000)
      ISUM5=((ISUM5+50)/100)/5
      CALL MPY53A(IX,ISUM5,ISUM6,1000)
      ISUM6=((ISUM6+50)/100)/6
      
      IVCF=ISUM1+ISUM2+ISUM3+ISUM4+ISUM5+ISUM6
      RETURN
      END
      
      SUBROUTINE MPY53A(IX,IY,IZ,ISCALE)
      
      
      IU1=IX/ISCALE
      K1=ISCALE*IU1
      IV1=IX-K1
      IU2=IY/ISCALE
      K2=ISCALE*IU2
      IV2=IY-K2
      K3=IU1*IV2+IU2*IV1+IV1*IV2/ISCALE
      IZ=(K3+ISCALE/2)/ISCALE + IU1*IU2
      RETURN
      END
      


      
