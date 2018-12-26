function lf = ILF_planar(elec,source)
    for i = 1:size(source,1)
        dist_kk = norm(elec(i,:)-source(i,:));
        for j = 1:size(source,1)
            x = norm(elec(j,:)-elec(i,:));
            hp = (1/(dist_kk.^2))/((x.^2/dist_kk.^2)+1).^(3/2);
            lf(i,j) = 1*hp;
        end
    end
end