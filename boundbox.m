function [position]=boundbox(binary,RGB)
    % Find the properties 
    imshow(RGB,'InitialMagnification','fit');
    props = regionprops(binary, 'BoundingBox');
    position=zeros(size(props,1),4);
    % Draw the bounding box
    for i = 1:size(props,1)
        rect = rectangle('Position', props(i).BoundingBox, 'EdgeColor', 'b', 'LineWidth', 1);
        position(i,:) = rect.Position;
        title_name = ['', num2str(i)];
        
        % Label the bounding boxes
        text(position(i,1)+position(i,3)/2, position(i,2)+position(i,4)/2, title_name, 'HorizontalAlignment', 'center', 'Color', 'w', 'FontSize', 20);
    end
end
