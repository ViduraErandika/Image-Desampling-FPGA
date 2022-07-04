module Memory(
	input wire clk,
	input wire fetch,
	input wire [17:0] address,
	output wire [17:0] Dout
	); 
	
	reg [7:0] memory [0:255];
	reg [17:0] d;
	
	assign Dout = d;
	//integer i;
	
	initial begin
    $readmemh("D:\\FPGA_Development\\Image-Desampling-FPGA\\instructionhexfile.txt",memory);

//    for(i=0; i<135 ; i=i+1)begin
//        $display("%h",memory[i]);
//    end
    end
	
	always @(fetch) begin
		if (fetch) d = {10'd0,memory[address]};
	end
	

	
endmodule
	