function D = ddt(A, dt)      % dao ham trung tam theo hang (giong numpy.gradient)
    D = [ (A(2,:)-A(1,:))/dt; (A(3:end,:)-A(1:end-2,:))/(2*dt); (A(end,:)-A(end-1,:))/dt ];
end