module Memory(
	input wire clk,
	input wire fetch,
	input wire [17:0] address,
	output wire [17:0] Dout
	); 
	
	reg [7:0] memory [0:255];
	reg [17:0] ADDRESS;
	reg [17:0] d;
	
	assign Dout = d;
	//integer i;
	
	initial begin
    $readmemh("D:\\FPGA_Development\\Image-Desampling-FPGA\\instructionhexfile.txt",memory);

//    for(i=0; i<135 ; i=i+1)begin
//        $display("%h",memory[i]);
//    end
    end
	
	always @(address)begin
	$monitor("The value of address has changed to %d",address);
	ADDRESS <= address;
	end
	
	always @(fetch, ADDRESS) begin
	$monitor("The value of d has changed to %d",d);
	$monitor("The value of fetch has changed to %d",fetch);
		if (fetch) d <= {10'd0,memory[ADDRESS[7:0]]};
	end
	

	
endmodule
	