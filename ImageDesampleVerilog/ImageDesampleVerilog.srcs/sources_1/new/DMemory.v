module DMemory(
	input wire clk,
	input wire write,
	input wire read,
	input wire [17:0] Din,
	input wire [17:0] address,
	output wire [17:0] Dout
	); 
	
	reg [7:0] memory [0:82950]; //128*128 + 66566
	reg [17:0] d;
	assign Dout = d;
	
	reg [17:0] ADDRESS;
	
	integer file_id;
	
	initial
	begin
	file_id = $fopen("D:\\FPGA_Development\\Image-Desampling-FPGA\\Desampled.txt","w");
	$readmemh("D:\\FPGA_Development\\Image-Desampling-FPGA\\imageArrayhexfile.txt",memory);
	end
	
	always @(address)begin
        ADDRESS <= address;	
	end
	
	always @(posedge clk) begin
		if (read) d = {10'd0,memory[ADDRESS]};
		else if (write)begin
		memory[ADDRESS] = Din[7:0];
		$fwrite(file_id,"%d",Din[7:0]);
		end
	end
	
	
endmodule
	