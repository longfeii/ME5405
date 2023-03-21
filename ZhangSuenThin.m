classdef ZhangSuenThin<handle
    properties
        img
        width
        length
        thinImg
    end
    
    methods
        function obj=ZhangSuenThin(img)
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
                    for y = 2:obj.width-1
                        if curimg(x,y)==1
                            P9=obj.img(x-1,y-1);
                            P2=obj.img(x-1,y);
                            P3=obj.img(x-1,y+1);
                            P8=obj.img(x,y-1);
                            P4=obj.img(x,y+1);
                            P7=obj.img(x+1,y-1);
                            P6=obj.img(x+1,y);
                            P5=obj.img(x+1,y+1);
                            NP1=P2+P3+P4+P5+P6+P7+P8+P9;
                            SP1=(P3-P2==1)+(P4-P3==1)+(P5-P4==1)+(P6-P5==1)+(P7-P6==1)+...
                                (P8-P7==1)+(P9-P8==1)+(P2-P9==1);                 
                            if (NP1>=2 && NP1<=6) && SP1==1
                                if P2*P4*P6==0 && P4*P6*P8==0 && mod(i,2)==1
                                    curimg(x,y)=0;
                                    judge=true;
                                elseif P2*P4*P8==0 && P2*P6*P8==0 && mod(i,2)==0
                                    curimg(x,y)=0;
                                    judge=true;
                                end
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
