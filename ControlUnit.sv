module ControlUnit(
input logic Clk, Reset,
output logic PCwrite, AluSrcA, Wr,
output logic [1:0]AluSrcB,
output logic [2:0]ALUFct
);

enum logic[1:0]{SendEnd, AttEnd,InitState}NextStage, Stage;

always_ff@(posedge Clk or posedge Reset) begin
	if(Reset) 
		Stage <= InitState;
	else
		Stage <= NextStage;
end

always_comb begin
	case(Stage)
	InitState:begin
		PCwrite = 1'b0;
		AluSrcA = 1'b0;
		Wr = 1'b0;
		AluSrcB = 2'b00;
		ALUFct = 3'b000;
		NextStage = SendEnd;
	end
	SendEnd: begin
		PCwrite = 1'b0;
		AluSrcA = 1'b0;
		Wr = 1'b0;
		AluSrcB = 2'b01;
		ALUFct = 3'b001;
		NextStage = AttEnd;
	end
	AttEnd: begin
		PCwrite = 1'b1;
		AluSrcA = 1'b0;
		Wr = 1'b0;
		AluSrcB = 2'b01;
		ALUFct = 3'b001;
		NextStage = SendEnd;
	end
	endcase
end

endmodule 