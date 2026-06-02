# S-box Circuit Synthesis and ADP Comparison
This repository provides the files needed to reproduce the ADP comparison between our lowest-ADP AES S-box circuit and the lowest-ADP circuit selected from [JBKK25].

## Contents
Each directory contains the circuit, scripts, and logs for one reproduced ADP result.

- `[Ours]AES10v2_23D_5AD_32NLs_82XORs_153ADP/`  
  Our lowest-ADP result: 82 XORs, 32 ANDs, depth 23, and AD=5.

- `[JBKK25]AES10_BPD_18D_6AD_32NLs_93XORs_193ADP/`  
  The lowest-ADP result among the circuits reported in [JBKK25]: 93 XORs, 32 ANDs, depth 18, and AD=6.

Each folder contains:

- `.py`: source circuit description
- `.v`: Verilog circuit
- `_mapped.v`: mapped Verilog netlist
- `synth.ys`: Yosys synthesis script
- `sta.tcl`: OpenSTA script
- `yosys.log`: synthesis log
- `sta.log`: timing log

## Synthesis and Timing Analysis

We used Yosys and OpenSTA with the Nangate 45nm Open Cell Library.

Tools:
- Yosys 0.65+71
- ABC, invoked by Yosys for technology mapping
- OpenSTA 3.1.0
- Nangate 45nm Open Cell Library

Flow:
1. Convert each circuit to Verilog.
2. Map the Verilog circuit with Yosys/ABC and extract the chip area from the Yosys log.
3. Use OpenSTA to obtain the critical-path delay.
4. Compute ADP as:
   
   `Area = chip area / NAND2_X1 area`

   `ADP = Area * delay`

where `NAND2_X1 area = 0.798` in the Nangate 45nm library.

The files `synth.ys` and `sta.tcl` contain the commands used in our experiments.

## Results

| Circuit | Area | Delay | ADP |
|---|---:|---:|---:|
| Ours | 190.33 | 0.8079 | 153.77 |
| JBKK25 | 218.67 | 0.8851 | 193.54 |

## Re-run

Update the Nangate liberty path in `synth.ys` and `sta.tcl`, then run:

```bash
yosys synth.ys | tee yosys.log
sta sta.tcl | tee sta.log
```
