classdef RobertsEdgeDetection<handle
    properties
        guassSize=3
        sigma=1
        img
        weak=30
        width
        length
        ImgGaussianFilter
        ImgGradientCalculation
        ImgTheta
        ImgSupperssion
        highThresholdRatio=0.09
        lowThresholdRatio=0.05
        ImgDoubleThreshold
        outlineImg
    end
    
    methods
        function obj=RobertsEdgeDetection(img)
%             obj.guassSize=guassSize;
%             obj.sigma=sigma;
            obj.img=img;
            obj.length=size(img,1);
            obj.width=size(img,2);

            obj.GaussianBlur();
            obj.GradientCalculation();
            obj.NonMaximumSuppression();
            obj.DoubleThreshold();
            obj.EdgeTracking();
        end

        function GaussianBlur(obj)
            gaussianKernel=zeros(obj.guassSize,obj.guassSize);
            obj.sigma=1;

            normal = 1 / (2.0 * pi * obj.sigma^2);
            midNumUp = ceil(obj.guassSize/2);
            midNumDown=midNumUp-1;
            for GKx=1:obj.guassSize
                for GKy=1:obj.guassSize
                    gaussianKernel(GKx,GKy)=exp(-(((GKx-midNumUp)^2 + (GKy-midNumUp)^2) / (2.0*obj.sigma^2))) * normal;
                end
            end

            obj.ImgGaussianFilter=obj.img;
            for x = midNumUp:obj.length-midNumUp+1
                for y = midNumUp:obj.width-midNumUp+1
                    obj.ImgGaussianFilter(x,y)=sum(sum(gaussianKernel.*obj.img(x-midNumDown:x+midNumDown,y-midNumDown:y+midNumDown)));
                end
            end
            figure(5)
            imshow(mat2gray(obj.ImgGaussianFilter),'InitialMagnification','fit')
        end

        function GradientCalculation(obj)
            Kx=[1 0;0 -1];
            Ky=[0 -1;1 0];
            
            obj.ImgGradientCalculation=zeros(obj.length,obj.width);
            obj.ImgTheta=zeros(obj.length,obj.width);
            for x = 2:obj.length
                for y = 2:obj.width
                    Ix=sum(sum(Kx.*obj.ImgGaussianFilter(x-1:x,y-1:y)));
                    Iy=sum(sum(Ky.*obj.ImgGaussianFilter(x-1:x,y-1:y)));
                    obj.ImgGradientCalculation(x,y)=(Ix^2+Iy^2)^0.5;
                    obj.ImgTheta(x,y)=atan(Iy/Ix);
                end
            end
            figure(6)
            imshow(mat2gray(obj.ImgGradientCalculation),'InitialMagnification','fit')
        end

        function NonMaximumSuppression(obj)
            obj.ImgSupperssion=zeros(obj.length,obj.width);
            obj.ImgTheta
            angle=obj.ImgTheta*180./pi;
            angle(angle<0)=angle(angle<0)+180;
            for x=2:obj.length-1
                for y=2:obj.width-1
                    q=255;
                    r=255;

                    if (0<=angle(x,y) && angle(x,y)<22.5) || (157.5<=angle(x,y) && angle(x,y)<=180)
                        q=obj.ImgGradientCalculation(x,y-1);
                        r=obj.ImgGradientCalculation(x,y+1);

                    elseif (22.5<=angle(x,y) && angle(x,y)<67.5)
                        q=obj.ImgGradientCalculation(x+1,y-1);
                        r=obj.ImgGradientCalculation(x-1,y+1);

                    elseif (67.5<=angle(x,y) && angle(x,y)<112.5)
                        q=obj.ImgGradientCalculation(x+1,y);
                        r=obj.ImgGradientCalculation(x-1,y);

                    elseif (112.5<=angle(x,y) && angle(x,y)<157.5)
                        q=obj.ImgGradientCalculation(x-1,y-1);
                        r=obj.ImgGradientCalculation(x+1,y+1);
                    end

                    if (obj.ImgGradientCalculation(x,y)>=q && obj.ImgGradientCalculation(x,y)>=r)
                        obj.ImgSupperssion(x,y)=obj.ImgGradientCalculation(x,y);
                    else
                        obj.ImgSupperssion(x,y)=0;
                    end
                end
            end
            figure(7)
            imshow(mat2gray(obj.ImgSupperssion),'InitialMagnification','fit')
        end

        function DoubleThreshold(obj)
            highThreshold=max(obj.ImgSupperssion)*obj.highThresholdRatio;
            lowThreshold=highThreshold*obj.lowThresholdRatio;
            obj.ImgDoubleThreshold=zeros(obj.length,obj.width);
            
            strong=255;


            for x = 1:obj.length
                for y = 1:obj.width
                    if obj.ImgSupperssion(x,y)>=highThreshold
                        obj.ImgDoubleThreshold(x,y)=strong;
                    elseif obj.ImgSupperssion(x,y)>=lowThreshold
                        obj.ImgDoubleThreshold(x,y)=obj.weak;
                    else
                        obj.ImgDoubleThreshold(x,y)=0;
                    end
                end
            end
%             figure(8)
%             imshow(mat2gray(obj.ImgDoubleThreshold),'InitialMagnification','fit')
        end

        function EdgeTracking(obj)
            ImgEdgeTracking=obj.ImgDoubleThreshold;
            
            strong=255;

            for x = 1:obj.length
                for y = 1:obj.width
                    if obj.ImgDoubleThreshold(x,y)==obj.weak
                        if (obj.ImgDoubleThreshold(x+1,y+1)==strong) || (obj.ImgDoubleThreshold(x+1,y)==strong)...
                                || (obj.ImgDoubleThreshold(x+1,y-1)==strong) || (obj.ImgDoubleThreshold(x,y+1)==strong)...
                                || (obj.ImgDoubleThreshold(x,y-1)==strong) || (obj.ImgDoubleThreshold(x-1,y+1)==strong)...
                                || (obj.ImgDoubleThreshold(x-1,y)==strong) || (obj.ImgDoubleThreshold(x-1,y-1)==strong)
                            ImgEdgeTracking(x,y)=strong;
                        else
                            ImgEdgeTracking(x,y)=0;
                        end
                    end
                end
            end
            obj.outlineImg=ImgEdgeTracking;
        end
    end
end

