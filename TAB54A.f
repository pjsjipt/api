c     Programas em fortran da API, tabela 54A

c      den15=779.0
c      degc=3.9
c      
c      call tab54a(den15, degc, vcfc, vcfp, iflag)
c      
c      print *, 'DEN15 = ',den15
c      print *, 'DEGC = ', degc
c      print *, 'VCFC = ', vcfc
c      print *, 'VCFP = ', vcfp
c      print *, 'IFLAG = ', iflag
      
      
c      end
      
      




      SUBROUTINE TAB54A(DEN15, DEGC, VCFC, VCFP, IFLAG)
      
      double precision DEN15, DEGC, VCFC, VCFP, IFLAG
      DATA IBAS/1500/
      DATA IBP1,IBP2/7785,8240/
      DATA NBP1/10750/
      DATA ITMP1,ITMP2,ITMP3/9500,12500,15000/
      DATA IEP1,IEP2,IEP3/6000,9000,12000/
      DATA IEDEN/7580/
      DATA IFDEN/6105/
      DATA IBT1/-1800/
      DATA K0,K1/6139723,0/
      
      IFLAG=-1
      VCFP=-1.00
      VCFC=-1.00
      
      IDEN=(DEN15*100 + 25.0) / 50.0
      IDEN=IDEN*5
      
      DEN15=FLOAT(IDEN)/10.0
      ITEMP=DEGC*1000.
      IF(ITEMP.GT.0)ITEMP=ITEMP+25
      IF(ITEMP.LT.0)ITEMP=ITEMP-25
      ITEMP=ITEMP/50*5
      
      DEGC=FLOAT(ITEMP)/100.0
      
      IF(IDEN-IFDEN) 10, 20, 20
 10   CONTINUE
      RETURN
 20   IF(IDEN-NBP1) 30, 30, 10
 30   CONTINUE
      
      IDT=ITEMP-IBAS
      IF(ITEMP-IBT1)40,50,50
 40   CONTINUE
      RETURN
 50   IF(IDEN-IBP1)60,60,70
 60   IF(ITEMP-ITMP1)100,100,40
 70   IF(IDEN-IBP2)80,80,90
 80   IF(ITEMP-ITMP2)100,100,40
 90   IF(ITEMP-ITMP3)100,100,40
 100  CONTINUE
      
      IDEN=IDEN*10
      CALL ALPHAA(IDEN,K0,K1,IALF)
      IDEN=IDEN/10
      CALL VCF54A(IALF,IDT,IVCF)
      IFLAG=0
      
      IF(IDEN-IEDEN)160,170,170
 160  CONTINUE
      IFLAG=1
      GO TO 220
 170  IF(IDEN-IBP1)190,180,180
 180  IF(ITEMP-IEP1)220,220,160
 190  IF(IDEN-IBP2)210,200,200
 200  IF(ITEMP-IEP2)220,220,160
 210  IF(ITEMP-IEP3)220,220,160
 220  CONTINUE
      
      
      JVCF=(IVCF/1000+5)/10
      PVCF=JVCF
      PVCF=PVCF/10000
      IF(IVCF-100000000)230,240,240
 230  CONTINUE
      
      
      JVCF=(IVCF/100+5)/10
      CVCF=JVCF
      CVCF=CVCF/100000
      
      GO TO 250
 240  CONTINUE
      CVCF=PVCF
 250  CONTINUE
      VCFP=PVCF
      VCFC=CVCF
      
      RETURN
      END
      
      SUBROUTINE SDIVA(INUM,IDENOM,IRES)
      
      IRES1=INUM/IDENOM
      IRES2=(INUM-IRES1*IDENOM)*10000/IDENOM
      IRES=IRES1*10000+IRES2
      RETURN
      END
      
      
      SUBROUTINE ALPHAA(IRHO,K0,K1,IALF)

      INUM=K1*10000
      CALL SDIVA(INUM,IRHO,IALF1)
      
      INUM=K0*100
      CALL SDIVA(INUM,IRHO,IALFS)
      CALL SDIVA(IALFS, IRHO, IALF2)
      IALF=(IALF1 + IALF2+500)/1000
      RETURN
      END
      
      SUBROUTINE VCF54A(IALF,IDT,IVCF)
      
      ITERM1=IALF*IDT
      ITERM1=ITERM1/10
      
      ITERM2=ITERM1/5*4
      
      CALL MPYA(ITERM1, ITERM2, ITERM3)
      IX = -(ITERM1 + ITERM3)
      
      ISUM1=100000000+IX
      CALL MPYA(IX,IX,ISUM2)
      ISUM2=ISUM2/2
      CALL MPYA(IX,ISUM2, ISUM3)
      ISUM3=ISUM3/3
      CALL MPYA(IX,ISUM3, ISUM4)
      ISUM4 = ISUM4/4
      CALL MPYA(IX,ISUM4,ISUM5)
      ISUM5=ISUM5/5
      CALL MPYA(IX,ISUM5,ISUM6)
      ISUM6=ISUM6/6
      IVCF=ISUM1+ISUM2+ISUM3+ISUM4+ISUM5+ISUM6
      RETURN
      END
      
      
      
      
      
      SUBROUTINE MPYA(IX,IY,IZ)
      IU1=IX/10000
      K1=10000*IU1
      IV1=IX-K1
      IU2 = IY/10000
      K2=10000*IU2
      IV2=IY-K2
      K3 = IU1*IV2 + IU2*IV1 + IV1*IV2 / 10000

      IZ=(K3+5000)/10000 + IU1*IU2
      RETURN
      END
      
      
      
      
