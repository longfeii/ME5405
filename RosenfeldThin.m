classdef RosenfeldThin<handle
    properties
        img
        width
        length
        thinImg
    end
    
    methods
        function obj=RosenfeldThin(img)
            obj.img=img;
            obj.length=size(img,1);
            obj.width=size(img,2);

            obj.Thin();
        end

        function Thin(obj)
            judge=true;
            curimg=obj.img;
            while judge==true 
                judge=false;
                for i =1:4
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
                                if (mod(i,4)==1 && P2==0) || (mod(i,4)==2 && P6==0) ...
                                        || (mod(i,4)==3 && P4==0) || (mod(i,4)==0 && P8==0)
                                    is8simple=1;
                                    if(P2==0&&P6==0)
                                        if((P9==1||P8==1||P7==1)&&(P3==1||P4==1||P5==1)) 
                                            is8simple = 0;
                                        end
                                    end
                        
                                    if(P4==0&&P8==0)
                            
                                        if((P9==1||P2==1||P3==1)&&(P5==1||P6==1||P7==1)) 
                                            is8simple = 0;
                                        end
                                    end
                                    if(P8==0&&P2==0)
                                        if(P9==1&&(P3==1||P4==1||P5==1||P6==1||P7==1))
                                            is8simple = 0;
                                        end
                                    end
                                    if(P4==0&&P2==0)
                                    
                                        if(P3==1&&(P5==1||P6==1||P7==1||P8==1||P9==1))
                                            is8simple = 0;
                                        end
                                    end
                                    if(P8==0&&P6==0)
                                        if(P7==1&&(P9==1||P2==1||P3==1||P4==1||P5==1))
                                            is8simple = 0;
                                        end
                                    end
                                    if(P4==0&&P6==0)
                                    
                                        if(P5==1&&(P7==1||P8==1||P9==1||P2==1||P3==1))
                                            is8simple = 0;
                                        end
                                    end
    
                                    Condi2=P2+P3+P4+P5+P6+P7+P8+P9>=2;
                                    if is8simple && Condi2
                                        curimg(x,y)=0;
                                        judge=true;
                                    end
                                end
                            end
                        end
                    end
                    obj.img=curimg;
                end
            end
            obj.thinImg=obj.img;
        end

    end
end
