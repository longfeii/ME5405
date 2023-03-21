classdef HilditchThin<handle
    properties
        img
        width
        length
        thinImg
    end
    
    methods
        function obj=HilditchThin(img)
            obj.img=img;
            obj.length=size(img,1);
            obj.width=size(img,2);

            obj.Thin();
        end

        function Thin(obj)
            judge=true;
            curimg=obj.img;
            i=0;
            while judge==true
                judge=false;
                i=i+1;
                for x = 2:obj.length-1
                    for y = 3:obj.width-1
                        if curimg(x,y)==1
                            P1=obj.img(x,y);
                            P9=obj.img(x-1,y-1);
                            P2=obj.img(x-1,y);
                            P3=obj.img(x-1,y+1);
                            P8=obj.img(x,y-1);
                            P4=obj.img(x,y+1);
                            P7=obj.img(x+1,y-1);
                            P6=obj.img(x+1,y);
                            P5=obj.img(x+1,y+1);
                            
                            B=P2+P3+P4+P5+P6+P7+P8+P9;
                            Condi1=(B>=2 && B<=6);
                            
                            A=(P3-P2==1)+(P4-P3==1)+(P5-P4==1)+(P6-P5==1)+(P7-P6==1)+...
                                (P8-P7==1)+(P9-P8==1)+(P2-P9==1);
                            Condi2=(A==1);
                            
                            P10=obj.img(x-2,y-1);
                            P11=obj.img(x-2,y);
                            P12=obj.img(x-2,y+1);

                            A2=(P3-P12==1)+(P4-P3==1)+(P1-P4==1)+(P8-P1==1)+(P9-P8==1)+...
                                (P10-P9==1)+(P11-P10==1)+(P12-P11==1);
                            
%                             P10=obj.img(x-1,y+2);
%                             P11=obj.img(x,y+2);
%                             P12=obj.img(x+1,y+2);
%                             A4=(P3-P2==1)+(P2-P1==1)+(P1-P6==1)+(P6-P5==1)+(P5-P12==1)+...
%                                 (P10-P3==1)+(P11-P10==1)+(P12-P11==1);

                            P10=obj.img(x-1,y-2);
                            P11=obj.img(x,y-2);
                            P12=obj.img(x+1,y-2);
                            A8=(P9-P10==1)+(P2-P9==1)+(P1-P2==1)+(P6-P1==1)+(P7-P6==1)+...
                                (P12-P7==1)+(P11-P12==1)+(P10-P11==1);

% && (A8==0 || P2*P4*P6==0)
                            if Condi1 && Condi2 && (A2==0 || P2*P4*P8==0)  && (A8==0 || P2*P6*P8==0)
                                curimg(x,y)=0;
                                judge=true;
                            end
                        end
                    end
                end
                obj.img=curimg;
            end
            obj.thinImg=obj.img;
        end

    end
end
