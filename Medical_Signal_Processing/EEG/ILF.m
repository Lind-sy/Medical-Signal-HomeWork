function lf = ILF(elec,source)
    for i = 1:size(source,1)
        v1 = elec(i,:)-source(i,:);
        for j = 1:size(source,1)
            dist = norm(elec(j,:)-source(i,:));
            v2 = elec(j,:)-source(i,:);
            alfa = dot(v1,v2)/(norm(v1)*norm(v2));
            lf(i,j) = alfa/dist.^2;
        end
    end
end