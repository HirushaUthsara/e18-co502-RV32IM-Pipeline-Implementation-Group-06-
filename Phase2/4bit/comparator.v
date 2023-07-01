module comparator (
    input OUTCOME,
    input PREDICTION,
    output MISS
);
    
    assign MISS = OUTCOME ^ PREDICTION;

endmodule
