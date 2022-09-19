# Connect 4 PvP : a one-line game for ZX Spectrum
#
# by Digital Prawn and Einar Saukas, with additional suggestions by Dr BEEP
#
# http://reptonix.awardspace.co.uk/sinclair/oneliners/connect4-pvp.htm
#
#
let n=23620: \
let p=2: \
poke n+73,8: \
cls : \
dim t(65): \
for x=1 to 6: \
    for y=2 to 8: \
        print at 20,y*3;y-1; paper t(x*8+y); flash t(x*8+y)=8;\
              at x*3-1,y*3;"  ";\
              at x*3,y*3;"  ": \
    next y: \
next x: \
if 49=x=t(5) then \
    border p: \
    input ': \
    let b=code inkey$-47: \
    poke (b<2 or b>8)*n,14: \
    poke (t(b+8)>0)*n,14: \
    let a=0: \
    beep .1,12-a: \
    print paper a=0;at a-1,b*3;"  ";\
                    at a,b*3;"  "; paper p;\
                    at a+2,b*3;"  ";\
                    at a+3,b*3;"  ": \
    let a=a+3: \
    let k=a*8/3+b: \
    poke (t(k+8)=0)*(a<18)*n,18: \
    let t(k)=p: \
    for j=1 to 4: \
        let l=0: \
        let d=j+5*(j>1): \
        for e=0 to 1: \
            let m=k: \
            let l=l+1: \
            let t(l)=m: \
            let m=m-d+2*d*e: \
            poke (t(m)=p)*n,29: \
        next e: \
        for f=1 to l*(l>4): \
            let t(t(f))=8: \
            beep .1,f*3: \
        next f: \
    next j: \
    let p=8-p: \
    poke n,6+4*(t(5)=0)
