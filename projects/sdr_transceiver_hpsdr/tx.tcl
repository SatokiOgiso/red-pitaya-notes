# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_0 {
  DIN_WIDTH 8 DIN_FROM 3 DIN_TO 3 DOUT_WIDTH 1
}

cell xilinx.com:ip:xlslice:1.0 slice_1 {
  DIN_WIDTH 96 DIN_FROM 31 DIN_TO 0 DOUT_WIDTH 32
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_2 {
  DIN_WIDTH 96 DIN_FROM 47 DIN_TO 32 DOUT_WIDTH 16
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_3 {
  DIN_WIDTH 96 DIN_FROM 63 DIN_TO 48 DOUT_WIDTH 16
}

# Create xlslice
cell xilinx.com:ip:xlslice:1.0 slice_4 {
  DIN_WIDTH 96 DIN_FROM 79 DIN_TO 64 DOUT_WIDTH 16
}

# Create axi_axis_writer
cell pavel-demin:user:axi_axis_writer:1.0 writer_0 {
  AXI_DATA_WIDTH 32
} {
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create fifo_generator
cell xilinx.com:ip:fifo_generator:13.1 fifo_generator_0 {
  PERFORMANCE_OPTIONS First_Word_Fall_Through
  INPUT_DATA_WIDTH 32
  INPUT_DEPTH 2048
  OUTPUT_DATA_WIDTH 32
  OUTPUT_DEPTH 2048
  DATA_COUNT true
  DATA_COUNT_WIDTH 12
} {
  clk /pll_0/clk_out1
}

# Create axis_fifo
cell pavel-demin:user:axis_fifo:1.0 fifo_0 {
  S_AXIS_TDATA_WIDTH 32
  M_AXIS_TDATA_WIDTH 32
} {
  S_AXIS writer_0/M_AXIS
  FIFO_READ fifo_generator_0/FIFO_READ
  FIFO_WRITE fifo_generator_0/FIFO_WRITE
  aclk /pll_0/clk_out1
}

# Create axis_subset_converter
cell xilinx.com:ip:axis_subset_converter:1.1 subset_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 4
  TDATA_REMAP {tdata[7:0],tdata[15:8],tdata[23:16],tdata[31:24]}
} {
  S_AXIS fifo_0/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_dwidth_converter
cell xilinx.com:ip:axis_dwidth_converter:1.1 conv_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 2
} {
  S_AXIS subset_0/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create fir_compiler
cell xilinx.com:ip:fir_compiler:7.2 fir_0 {
  DATA_WIDTH.VALUE_SRC USER
  DATA_WIDTH 16
  COEFFICIENTVECTOR {-1.6278583749e-08, -4.5104335216e-08, 1.8643238703e-10, 2.9518100256e-08, 1.6311668874e-08, 3.1133681432e-08, -3.8485539239e-09, -1.4496770037e-07, -8.2348991437e-08, 2.9937360243e-07, 2.9598773091e-07, -4.5094100085e-07, -6.8677196871e-07, 5.1944305851e-07, 1.2813799827e-06, -3.9025624673e-07, -2.0620561572e-06, -7.2763738594e-08, 2.9467958813e-06, 1.0022594115e-06, -3.7776536280e-06, -2.4921695179e-06, 4.3233346157e-06, 4.5572931869e-06, -4.3010589667e-06, -7.0958807987e-06, 3.4194451300e-06, 9.8655347899e-06, -1.4397018132e-06, -1.2483145541e-05, -1.7531304190e-06, 1.4457261586e-05, 6.0821714072e-06, -1.5256563422e-05, -1.1231147383e-05, 1.4410068309e-05, 1.6633274615e-05, -1.1630690946e-05, -2.1518372186e-05, 6.9311743997e-06, 2.5013333856e-05, -7.1818040873e-07, -2.6304243924e-05, -6.1744598820e-06, 2.4836281635e-05, 1.2535520867e-05, -2.0521832409e-05, -1.6925480024e-05, 1.3913857425e-05, 1.7923375998e-05, -6.2972919510e-06, -1.4449694558e-05, -3.4620041308e-07, 6.1206012671e-06, 3.5305735921e-06, 6.4294495935e-06, -6.2270472593e-07, -2.1331802745e-05, -1.0659990885e-05, 3.5444490810e-05, 3.1658636026e-05, -4.4572750908e-05, -6.2221593684e-05, 4.3914342607e-05, 1.0022883041e-04, -2.8794119985e-05, -1.4138599782e-04, -4.4410295010e-06, 1.7935164513e-04, 5.7464786503e-05, -2.0627343640e-04, -1.2911737100e-04, 2.1373727566e-04, 2.1483614434e-04, -1.9406127810e-04, -3.0654650750e-04, 1.4178437355e-04, 3.9314444115e-04, -5.5130787833e-05, -4.6162887546e-04, -6.2817909035e-05, 4.9883735128e-04, 2.0351771369e-04, -4.9363723808e-04, -3.5321408521e-04, 4.3918593995e-04, 4.9401653821e-04, -3.3516452954e-04, -6.0615931268e-04, 1.8920172903e-04, 6.7096892179e-04, -1.7350955410e-05, -6.7440278901e-04, -1.5680392675e-04, 6.1063649055e-04, 3.0456712827e-04, -4.8511288738e-04, -3.9603152123e-04, 3.1641789232e-04, 4.0516601081e-04, -1.3640259101e-04, -3.1554823891e-04, -1.1883132473e-05, 1.2598053968e-04, 7.8631635673e-05, 1.4491298202e-04, -1.3969570155e-05, -4.5610222421e-04, -2.2378320086e-04, 7.4397749846e-04, 6.5835462984e-04, -9.2630980215e-04, -1.2867792077e-03, 9.0909156314e-04, 2.0715811175e-03, -5.9716488691e-04, -2.9359477263e-03, -9.2463414834e-05, 3.7628678529e-03, 1.2156917746e-03, -4.3990734542e-03, -2.7862612849e-03, 4.6641282868e-03, 4.7622285630e-03, -4.3644247141e-03, -7.0356212669e-03, 3.3112164722e-03, 9.4266299861e-03, -1.3412354458e-03, -1.1683103269e-02, -1.6620127318e-03, 1.3484958927e-02, 5.7472746753e-03, -1.4454699130e-02, -1.0881151329e-02, 1.4164854778e-02, 1.6933807785e-02, -1.2145465112e-02, -2.3672753626e-02, 7.8756806946e-03, 3.0757968251e-02, -7.4318033188e-04, -3.7730976788e-02, -1.0069903021e-02, 4.3972783795e-02, 2.5878915097e-02, -4.8548541342e-02, -4.9281216309e-02, 4.9608677905e-02, 8.6599384013e-02, -4.1546560705e-02, -1.5767521732e-01, -5.9696600342e-03, 3.5273682025e-01, 5.4609132429e-01, 3.5273682025e-01, -5.9696600342e-03, -1.5767521732e-01, -4.1546560705e-02, 8.6599384013e-02, 4.9608677905e-02, -4.9281216309e-02, -4.8548541342e-02, 2.5878915097e-02, 4.3972783795e-02, -1.0069903021e-02, -3.7730976788e-02, -7.4318033188e-04, 3.0757968251e-02, 7.8756806946e-03, -2.3672753626e-02, -1.2145465112e-02, 1.6933807785e-02, 1.4164854778e-02, -1.0881151329e-02, -1.4454699130e-02, 5.7472746753e-03, 1.3484958927e-02, -1.6620127318e-03, -1.1683103269e-02, -1.3412354458e-03, 9.4266299861e-03, 3.3112164722e-03, -7.0356212669e-03, -4.3644247141e-03, 4.7622285630e-03, 4.6641282868e-03, -2.7862612849e-03, -4.3990734542e-03, 1.2156917746e-03, 3.7628678529e-03, -9.2463414834e-05, -2.9359477263e-03, -5.9716488691e-04, 2.0715811175e-03, 9.0909156314e-04, -1.2867792077e-03, -9.2630980215e-04, 6.5835462984e-04, 7.4397749846e-04, -2.2378320086e-04, -4.5610222421e-04, -1.3969570155e-05, 1.4491298202e-04, 7.8631635673e-05, 1.2598053968e-04, -1.1883132473e-05, -3.1554823891e-04, -1.3640259101e-04, 4.0516601081e-04, 3.1641789232e-04, -3.9603152123e-04, -4.8511288738e-04, 3.0456712827e-04, 6.1063649055e-04, -1.5680392675e-04, -6.7440278901e-04, -1.7350955411e-05, 6.7096892179e-04, 1.8920172903e-04, -6.0615931268e-04, -3.3516452954e-04, 4.9401653821e-04, 4.3918593995e-04, -3.5321408521e-04, -4.9363723808e-04, 2.0351771369e-04, 4.9883735128e-04, -6.2817909035e-05, -4.6162887546e-04, -5.5130787833e-05, 3.9314444115e-04, 1.4178437355e-04, -3.0654650750e-04, -1.9406127810e-04, 2.1483614434e-04, 2.1373727566e-04, -1.2911737100e-04, -2.0627343640e-04, 5.7464786503e-05, 1.7935164513e-04, -4.4410295010e-06, -1.4138599782e-04, -2.8794119985e-05, 1.0022883041e-04, 4.3914342607e-05, -6.2221593684e-05, -4.4572750908e-05, 3.1658636026e-05, 3.5444490810e-05, -1.0659990885e-05, -2.1331802745e-05, -6.2270472593e-07, 6.4294495935e-06, 3.5305735921e-06, 6.1206012671e-06, -3.4620041308e-07, -1.4449694558e-05, -6.2972919510e-06, 1.7923375998e-05, 1.3913857425e-05, -1.6925480024e-05, -2.0521832409e-05, 1.2535520867e-05, 2.4836281635e-05, -6.1744598820e-06, -2.6304243924e-05, -7.1818040873e-07, 2.5013333856e-05, 6.9311743997e-06, -2.1518372186e-05, -1.1630690946e-05, 1.6633274615e-05, 1.4410068309e-05, -1.1231147383e-05, -1.5256563422e-05, 6.0821714072e-06, 1.4457261586e-05, -1.7531304190e-06, -1.2483145541e-05, -1.4397018132e-06, 9.8655347899e-06, 3.4194451300e-06, -7.0958807987e-06, -4.3010589667e-06, 4.5572931869e-06, 4.3233346157e-06, -2.4921695179e-06, -3.7776536280e-06, 1.0022594115e-06, 2.9467958813e-06, -7.2763738594e-08, -2.0620561572e-06, -3.9025624673e-07, 1.2813799827e-06, 5.1944305851e-07, -6.8677196871e-07, -4.5094100085e-07, 2.9598773091e-07, 2.9937360243e-07, -8.2348991437e-08, -1.4496770037e-07, -3.8485539239e-09, 3.1133681432e-08, 1.6311668874e-08, 2.9518100256e-08, 1.8643238703e-10, -4.5104335216e-08, -1.6278583749e-08}
  COEFFICIENT_WIDTH 24
  QUANTIZATION Quantize_Only
  BESTPRECISION true
  FILTER_TYPE Interpolation
  INTERPOLATION_RATE 2
  NUMBER_CHANNELS 2
  NUMBER_PATHS 1
  SAMPLE_FREQUENCY 0.048
  CLOCK_FREQUENCY 125
  OUTPUT_ROUNDING_MODE Convergent_Rounding_to_Even
  OUTPUT_WIDTH 25
  M_DATA_HAS_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA conv_0/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_subset_converter
cell xilinx.com:ip:axis_subset_converter:1.1 subset_1 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 3
  TDATA_REMAP {tdata[23:0]}
} {
  S_AXIS fir_0/M_AXIS_DATA
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create fir_compiler
cell xilinx.com:ip:fir_compiler:7.2 fir_1 {
  DATA_WIDTH.VALUE_SRC USER
  DATA_WIDTH 24
  COEFFICIENTVECTOR {-1.5956605232e-08, -1.4027210574e-08, -1.1469474085e-08, -8.2836180146e-09, -4.4848080991e-09, -1.0407677321e-10, 4.8110008357e-09, 1.0195908361e-08, 1.5969094293e-08, 2.2032206221e-08, 2.8270672406e-08, 3.4554644949e-08, 4.0740313387e-08, 4.6671591588e-08, 5.2182174508e-08, 5.7097954686e-08, 6.1239781454e-08, 6.4426538826e-08, 6.6478510946e-08, 6.7220997028e-08, 6.6488130959e-08, 6.4126854274e-08, 6.0000985295e-08, 5.3995321744e-08, 4.6019709490e-08, 3.6013006137e-08, 2.3946865196e-08, 9.8292645898e-09, -6.2922976469e-09, -2.4328017293e-08, -4.4143482806e-08, -6.5557931595e-08, -8.8343132082e-08, -1.1222295444e-07, -1.3687368619e-07, -1.6192514079e-07, -1.8696259810e-07, -2.1152960516e-07, -2.3513165443e-07, -2.5724074395e-07, -2.7730081109e-07, -2.9473401721e-07, -3.0894784686e-07, -3.1934296990e-07, -3.2532180081e-07, -3.2629767448e-07, -3.2170454392e-07, -3.1100709153e-07, -2.9371113275e-07, -2.6937417944e-07, -2.3761601956e-07, -1.9812916099e-07, -1.5068897995e-07, -9.5163409297e-08, -3.1521998405e-08, 4.0155824245e-08, 1.1967345374e-07, 2.0671094052e-07, 3.0082010894e-07, 4.0142111114e-07, 5.0780055343e-07, 6.1911131812e-07, 7.3437418709e-07, 8.5248135465e-07, 9.7220189568e-07, 1.0921892320e-06, 1.2109906146e-06, 1.3270586133e-06, 1.4387645756e-06, 1.5444139913e-06, 1.6422636642e-06, 1.7305405697e-06, 1.8074622400e-06, 1.8712584962e-06, 1.9201943142e-06, 1.9525935870e-06, 1.9668635208e-06, 1.9615193811e-06, 1.9352092825e-06, 1.8867387042e-06, 1.8150943962e-06, 1.7194673338e-06, 1.5992743742e-06, 1.4541782669e-06, 1.2841056739e-06, 1.0892628669e-06, 8.7014877882e-07, 6.2756510963e-07, 3.6262320741e-07, 7.6747475520e-08, -2.2832491072e-07, -5.5054815637e-07, -8.8757600555e-07, -1.2367739979e-06, -1.5952358658e-06, -1.9598040633e-06, -2.3270943647e-06, -2.6935244141e-06, -3.0553460519e-06, -3.4086811865e-06, -3.7495609242e-06, -4.0739676135e-06, -4.3778794099e-06, -4.6573169136e-06, -4.9083913879e-06, -5.1273540235e-06, -5.3106456767e-06, -5.4549464756e-06, -5.5572246687e-06, -5.6147840662e-06, -5.6253094176e-06, -5.5869090670e-06, -5.4981542305e-06, -5.3581142599e-06, -5.1663872742e-06, -4.9231255797e-06, -4.6290553358e-06, -4.2854899774e-06, -3.8943369612e-06, -3.4580974711e-06, -2.9798587931e-06, -2.4632791492e-06, -1.9125648688e-06, -1.3324398685e-06, -7.2810750670e-07, -1.0520498256e-07, 5.3024945391e-07, 1.1719161057e-06, 1.8131997731e-06, 2.4473214626e-06, 3.0673951871e-06, 3.6665090930e-06, 4.2378100594e-06, 4.7745908391e-06, 5.2703787377e-06, 5.7190247651e-06, 6.1147921466e-06, 6.4524430401e-06, 6.7273222820e-06, 6.9354369744e-06, 7.0735307280e-06, 7.1391513965e-06, 7.1307111696e-06, 7.0475379464e-06, 6.8899169725e-06, 6.6591218089e-06, 6.3574337970e-06, 5.9881492925e-06, 5.5555740719e-06, 5.0650044462e-06, 4.5226947708e-06, 3.9358111968e-06, 3.3123716776e-06, 2.6611724198e-06, 1.9917011434e-06, 1.3140377019e-06, 6.3874279225e-07, -2.3264333924e-08, -6.6083807074e-07, -1.2627473117e-06, -1.8178235389e-06, -2.3151145785e-06, -2.7440423186e-06, -3.0945625625e-06, -3.3573250902e-06, -3.5238319147e-06, -3.5865916620e-06, -3.5392679602e-06, -3.3768197153e-06, -3.0956311575e-06, -2.6936295845e-06, -2.1703887919e-06, -1.5272162734e-06, -7.6722239540e-07, 1.0463010362e-07, 1.0814977654e-06, 2.1546504936e-06, 3.3134891205e-06, 4.5455872726e-06, 5.8367580846e-06, 7.1711460306e-06, 8.5313438483e-06, 9.8985342262e-06, 1.1252655607e-05, 1.2572591147e-05, 1.3836379541e-05, 1.5021446129e-05, 1.6104852355e-05, 1.7063561385e-05, 1.7874717387e-05, 1.8515935714e-05, 1.8965600991e-05, 1.9203169893e-05, 1.9209475203e-05, 1.8967027605e-05, 1.8460311534e-05, 1.7676071333e-05, 1.6603583936e-05, 1.5234914303e-05, 1.3565149875e-05, 1.1592610425e-05, 9.3190298319e-06, 6.7497064845e-06, 3.8936192584e-06, 7.6350630891e-07, -2.6240957719e-06, -6.2488545081e-06, -1.0086687476e-05, -1.4109852857e-05, -1.8287085377e-05, -2.2583777896e-05, -2.6962208404e-05, -3.1381811650e-05, -3.5799494072e-05, -4.0169990162e-05, -4.4446257862e-05, -4.8579910017e-05, -5.2521678430e-05, -5.6221906542e-05, -5.9631066274e-05, -6.2700294162e-05, -6.5381941495e-05, -6.7630132812e-05, -6.9401326846e-05, -7.0654873715e-05, -7.1353562034e-05, -7.1464149461e-05, -7.0957870187e-05, -6.9810912891e-05, -6.8004862796e-05, -6.5527101630e-05, -6.2371159588e-05, -5.8537013692e-05, -5.4031327375e-05, -4.8867626603e-05, -4.3066408392e-05, -3.6655178207e-05, -2.9668413403e-05, -2.2147450604e-05, -1.4140295714e-05, -5.7013560503e-06, 3.1089050157e-06, 1.2224389678e-05, 2.1573861426e-05, 3.1081511833e-05, 4.0667594474e-05, 5.0249121134e-05, 5.9740614636e-05, 6.9054911790e-05, 7.8104009194e-05, 8.6799943892e-05, 9.5055700285e-05, 1.0278613406e-04, 1.0990890350e-04, 1.1634539804e-04, 1.2202165378e-04, 1.2686924534e-04, 1.3082614351e-04, 1.3383752813e-04, 1.3585654577e-04, 1.3684500217e-04, 1.3677397976e-04, 1.3562437113e-04, 1.3338731997e-04, 1.3006456185e-04, 1.2566865799e-04, 1.2022311620e-04, 1.1376239437e-04, 1.0633178295e-04, 9.7987164100e-05, 8.8794646614e-05, 7.8830077091e-05, 6.8178429108e-05, 5.6933073764e-05, 4.5194936278e-05, 3.3071544850e-05, 2.0675979360e-05, 8.1257288733e-06, -4.4585317552e-06, -1.6954234655e-05, -2.9238268401e-05, -4.1188370443e-05, -5.2684547827e-05, -6.3610510775e-05, -7.3855103032e-05, -8.3313712401e-05, -9.1889644585e-05, -9.9495443335e-05, -1.0605413994e-04, -1.1150041536e-04, -1.1578165875e-04, -1.1885890672e-04, -1.2070764867e-04, -1.2131848429e-04, -1.2069762091e-04, -1.1886719938e-04, -1.1586543913e-04, -1.1174659448e-04, -1.0658071633e-04, -1.0045321531e-04, -9.3464224592e-05, -8.5727762765e-05, -7.7370699499e-05, -6.8531529009e-05, -5.9358958701e-05, -5.0010322735e-05, -4.0649832552e-05, -3.1446678710e-05, -2.2573000519e-05, -1.4201742099e-05, -6.5044153953e-06, 3.5120750098e-07, 6.2034487662e-06, 1.0899100647e-05, 1.4295796108e-05, 1.6264346877e-05, 1.6691020751e-05, 1.5479729684e-05, 1.2554100054e-05, 7.8593967732e-06, 1.3642734054e-06, -6.9376786660e-06, -1.7026607803e-05, -2.8855330706e-05, -4.2348534519e-05, -5.7402272810e-05, -7.3883773406e-05, -9.1631573362e-05, -1.1045599342e-04, -1.3013996111e-04, -1.5044018834e-04, -1.7108870568e-04, -1.9179475178e-04, -2.1224701281e-04, -2.3211620244e-04, -2.5105796944e-04, -2.6871611549e-04, -2.8472610246e-04, -2.9871882389e-04, -3.1032461238e-04, -3.1917745045e-04, -3.2491934938e-04, -3.2720485744e-04, -3.2570565586e-04, -3.2011519848e-04, -3.1015334908e-04, -2.9557096815e-04, -2.7615439990e-04, -2.5172980928e-04, -2.2216731813e-04, -1.8738489005e-04, -1.4735191357e-04, -1.0209243483e-04, -5.1687991989e-05, 3.7199938582e-06, 6.3928314195e-05, 1.2867059474e-04, 1.9761647936e-04, 2.7037140842e-04, 3.4647701899e-04, 4.2541218973e-04, 5.0659474788e-04, 5.8938384984e-04, 6.7308304156e-04, 7.5694399804e-04, 8.4017093551e-04, 9.2192568285e-04, 1.0013333926e-03, 1.0774888653e-03, 1.1494634532e-03, 1.2163125057e-03, 1.2770833088e-03, 1.3308234672e-03, 1.3765896730e-03, 1.4134567946e-03, 1.4405272208e-03, 1.4569403856e-03, 1.4618823968e-03, 1.4545956891e-03, 1.4343886173e-03, 1.4006449055e-03, 1.3528328641e-03, 1.2905142880e-03, 1.2133529472e-03, 1.1211225846e-03, 1.0137143331e-03, 8.9114347134e-04, 7.5355543687e-04, 6.0123102058e-04, 4.3459067171e-04, 2.5419784686e-04, 6.0761343544e-05, -1.4486343514e-04, -3.6167432999e-04, -5.8852342735e-04, -8.2411924169e-04, -1.0670300995e-03, -1.3156887354e-03, -1.5683981009e-03, -1.8233383777e-03, -2.0785751767e-03, -2.3320688923e-03, -2.5816851749e-03, -2.8252064702e-03, -3.0603445681e-03, -3.2847540902e-03, -3.4960468413e-03, -3.6918069340e-03, -3.8696065959e-03, -4.0270225528e-03, -4.1616528819e-03, -4.2711342164e-03, -4.3531591827e-03, -4.4054939440e-03, -4.4259957199e-03, -4.4126301534e-03, -4.3634883893e-03, -4.2768037321e-03, -4.1509677498e-03, -3.9845456928e-03, -3.7762910988e-03, -3.5251594592e-03, -3.2303208274e-03, -2.8911712552e-03, -2.5073429495e-03, -2.0787130514e-03, -1.6054109473e-03, -1.0878240306e-03, -5.2660184436e-04, 7.7341453020e-05, 7.2282634865e-04, 1.4084089952e-03, 2.1323840137e-03, 2.8927890879e-03, 3.6874113458e-03, 4.5137955113e-03, 5.3692537945e-03, 6.2508774766e-03, 7.1555501312e-03, 8.0799624131e-03, 9.0206283296e-03, 9.9739029013e-03, 1.0936001106e-02, 1.1903017987e-02, 1.2870949804e-02, 1.3835716085e-02, 1.4793182440e-02, 1.5739183989e-02, 1.6669549236e-02, 1.7580124250e-02, 1.8466796963e-02, 1.9325521439e-02, 2.0152341940e-02, 2.0943416620e-02, 2.1695040685e-02, 2.2403668852e-02, 2.3065936961e-02, 2.3678682569e-02, 2.4238964396e-02, 2.4744080481e-02, 2.5191584907e-02, 2.5579302993e-02, 2.5905344835e-02, 2.6168117090e-02, 2.6366332945e-02, 2.6499020161e-02, 2.6565527173e-02, 2.6565527173e-02, 2.6499020161e-02, 2.6366332945e-02, 2.6168117090e-02, 2.5905344835e-02, 2.5579302993e-02, 2.5191584907e-02, 2.4744080481e-02, 2.4238964396e-02, 2.3678682569e-02, 2.3065936961e-02, 2.2403668852e-02, 2.1695040685e-02, 2.0943416620e-02, 2.0152341940e-02, 1.9325521439e-02, 1.8466796963e-02, 1.7580124250e-02, 1.6669549236e-02, 1.5739183989e-02, 1.4793182440e-02, 1.3835716085e-02, 1.2870949804e-02, 1.1903017987e-02, 1.0936001106e-02, 9.9739029013e-03, 9.0206283296e-03, 8.0799624131e-03, 7.1555501312e-03, 6.2508774766e-03, 5.3692537945e-03, 4.5137955113e-03, 3.6874113458e-03, 2.8927890879e-03, 2.1323840137e-03, 1.4084089952e-03, 7.2282634865e-04, 7.7341453020e-05, -5.2660184436e-04, -1.0878240306e-03, -1.6054109473e-03, -2.0787130514e-03, -2.5073429495e-03, -2.8911712552e-03, -3.2303208274e-03, -3.5251594592e-03, -3.7762910988e-03, -3.9845456928e-03, -4.1509677498e-03, -4.2768037321e-03, -4.3634883893e-03, -4.4126301534e-03, -4.4259957199e-03, -4.4054939440e-03, -4.3531591827e-03, -4.2711342164e-03, -4.1616528819e-03, -4.0270225528e-03, -3.8696065959e-03, -3.6918069340e-03, -3.4960468413e-03, -3.2847540902e-03, -3.0603445681e-03, -2.8252064702e-03, -2.5816851749e-03, -2.3320688923e-03, -2.0785751767e-03, -1.8233383777e-03, -1.5683981009e-03, -1.3156887354e-03, -1.0670300995e-03, -8.2411924169e-04, -5.8852342735e-04, -3.6167432999e-04, -1.4486343514e-04, 6.0761343544e-05, 2.5419784686e-04, 4.3459067171e-04, 6.0123102058e-04, 7.5355543687e-04, 8.9114347134e-04, 1.0137143331e-03, 1.1211225846e-03, 1.2133529472e-03, 1.2905142880e-03, 1.3528328641e-03, 1.4006449055e-03, 1.4343886173e-03, 1.4545956891e-03, 1.4618823968e-03, 1.4569403856e-03, 1.4405272208e-03, 1.4134567946e-03, 1.3765896730e-03, 1.3308234672e-03, 1.2770833088e-03, 1.2163125057e-03, 1.1494634532e-03, 1.0774888653e-03, 1.0013333926e-03, 9.2192568285e-04, 8.4017093551e-04, 7.5694399804e-04, 6.7308304156e-04, 5.8938384984e-04, 5.0659474788e-04, 4.2541218973e-04, 3.4647701899e-04, 2.7037140842e-04, 1.9761647936e-04, 1.2867059474e-04, 6.3928314195e-05, 3.7199938582e-06, -5.1687991989e-05, -1.0209243483e-04, -1.4735191357e-04, -1.8738489005e-04, -2.2216731813e-04, -2.5172980928e-04, -2.7615439990e-04, -2.9557096815e-04, -3.1015334908e-04, -3.2011519848e-04, -3.2570565586e-04, -3.2720485744e-04, -3.2491934938e-04, -3.1917745045e-04, -3.1032461238e-04, -2.9871882389e-04, -2.8472610246e-04, -2.6871611549e-04, -2.5105796944e-04, -2.3211620244e-04, -2.1224701281e-04, -1.9179475178e-04, -1.7108870568e-04, -1.5044018834e-04, -1.3013996111e-04, -1.1045599342e-04, -9.1631573362e-05, -7.3883773406e-05, -5.7402272810e-05, -4.2348534519e-05, -2.8855330706e-05, -1.7026607803e-05, -6.9376786660e-06, 1.3642734054e-06, 7.8593967732e-06, 1.2554100054e-05, 1.5479729684e-05, 1.6691020751e-05, 1.6264346877e-05, 1.4295796108e-05, 1.0899100647e-05, 6.2034487662e-06, 3.5120750098e-07, -6.5044153953e-06, -1.4201742099e-05, -2.2573000519e-05, -3.1446678710e-05, -4.0649832552e-05, -5.0010322735e-05, -5.9358958701e-05, -6.8531529009e-05, -7.7370699499e-05, -8.5727762765e-05, -9.3464224592e-05, -1.0045321531e-04, -1.0658071633e-04, -1.1174659448e-04, -1.1586543913e-04, -1.1886719938e-04, -1.2069762091e-04, -1.2131848429e-04, -1.2070764867e-04, -1.1885890672e-04, -1.1578165875e-04, -1.1150041536e-04, -1.0605413994e-04, -9.9495443335e-05, -9.1889644585e-05, -8.3313712401e-05, -7.3855103032e-05, -6.3610510775e-05, -5.2684547827e-05, -4.1188370443e-05, -2.9238268401e-05, -1.6954234655e-05, -4.4585317552e-06, 8.1257288733e-06, 2.0675979360e-05, 3.3071544850e-05, 4.5194936278e-05, 5.6933073764e-05, 6.8178429108e-05, 7.8830077091e-05, 8.8794646614e-05, 9.7987164100e-05, 1.0633178295e-04, 1.1376239437e-04, 1.2022311620e-04, 1.2566865799e-04, 1.3006456185e-04, 1.3338731997e-04, 1.3562437113e-04, 1.3677397976e-04, 1.3684500217e-04, 1.3585654577e-04, 1.3383752813e-04, 1.3082614351e-04, 1.2686924534e-04, 1.2202165378e-04, 1.1634539804e-04, 1.0990890350e-04, 1.0278613406e-04, 9.5055700285e-05, 8.6799943892e-05, 7.8104009194e-05, 6.9054911790e-05, 5.9740614636e-05, 5.0249121134e-05, 4.0667594474e-05, 3.1081511833e-05, 2.1573861426e-05, 1.2224389678e-05, 3.1089050157e-06, -5.7013560503e-06, -1.4140295714e-05, -2.2147450604e-05, -2.9668413403e-05, -3.6655178207e-05, -4.3066408392e-05, -4.8867626603e-05, -5.4031327375e-05, -5.8537013692e-05, -6.2371159588e-05, -6.5527101630e-05, -6.8004862796e-05, -6.9810912891e-05, -7.0957870187e-05, -7.1464149461e-05, -7.1353562034e-05, -7.0654873715e-05, -6.9401326846e-05, -6.7630132812e-05, -6.5381941495e-05, -6.2700294162e-05, -5.9631066274e-05, -5.6221906542e-05, -5.2521678430e-05, -4.8579910017e-05, -4.4446257862e-05, -4.0169990162e-05, -3.5799494072e-05, -3.1381811650e-05, -2.6962208404e-05, -2.2583777896e-05, -1.8287085377e-05, -1.4109852857e-05, -1.0086687476e-05, -6.2488545081e-06, -2.6240957719e-06, 7.6350630891e-07, 3.8936192584e-06, 6.7497064845e-06, 9.3190298319e-06, 1.1592610425e-05, 1.3565149875e-05, 1.5234914303e-05, 1.6603583936e-05, 1.7676071333e-05, 1.8460311534e-05, 1.8967027605e-05, 1.9209475203e-05, 1.9203169893e-05, 1.8965600991e-05, 1.8515935714e-05, 1.7874717387e-05, 1.7063561385e-05, 1.6104852355e-05, 1.5021446129e-05, 1.3836379541e-05, 1.2572591147e-05, 1.1252655607e-05, 9.8985342262e-06, 8.5313438483e-06, 7.1711460306e-06, 5.8367580846e-06, 4.5455872726e-06, 3.3134891205e-06, 2.1546504936e-06, 1.0814977654e-06, 1.0463010362e-07, -7.6722239540e-07, -1.5272162734e-06, -2.1703887919e-06, -2.6936295845e-06, -3.0956311575e-06, -3.3768197153e-06, -3.5392679602e-06, -3.5865916620e-06, -3.5238319147e-06, -3.3573250902e-06, -3.0945625625e-06, -2.7440423186e-06, -2.3151145785e-06, -1.8178235389e-06, -1.2627473117e-06, -6.6083807074e-07, -2.3264333925e-08, 6.3874279225e-07, 1.3140377019e-06, 1.9917011434e-06, 2.6611724198e-06, 3.3123716776e-06, 3.9358111968e-06, 4.5226947708e-06, 5.0650044462e-06, 5.5555740719e-06, 5.9881492925e-06, 6.3574337970e-06, 6.6591218089e-06, 6.8899169725e-06, 7.0475379464e-06, 7.1307111696e-06, 7.1391513965e-06, 7.0735307280e-06, 6.9354369744e-06, 6.7273222820e-06, 6.4524430401e-06, 6.1147921466e-06, 5.7190247651e-06, 5.2703787377e-06, 4.7745908391e-06, 4.2378100594e-06, 3.6665090930e-06, 3.0673951871e-06, 2.4473214626e-06, 1.8131997731e-06, 1.1719161057e-06, 5.3024945391e-07, -1.0520498256e-07, -7.2810750670e-07, -1.3324398685e-06, -1.9125648688e-06, -2.4632791492e-06, -2.9798587931e-06, -3.4580974711e-06, -3.8943369612e-06, -4.2854899774e-06, -4.6290553358e-06, -4.9231255797e-06, -5.1663872742e-06, -5.3581142599e-06, -5.4981542305e-06, -5.5869090670e-06, -5.6253094176e-06, -5.6147840662e-06, -5.5572246687e-06, -5.4549464756e-06, -5.3106456767e-06, -5.1273540235e-06, -4.9083913879e-06, -4.6573169136e-06, -4.3778794099e-06, -4.0739676135e-06, -3.7495609242e-06, -3.4086811865e-06, -3.0553460519e-06, -2.6935244141e-06, -2.3270943647e-06, -1.9598040633e-06, -1.5952358658e-06, -1.2367739979e-06, -8.8757600555e-07, -5.5054815637e-07, -2.2832491072e-07, 7.6747475520e-08, 3.6262320741e-07, 6.2756510963e-07, 8.7014877882e-07, 1.0892628669e-06, 1.2841056739e-06, 1.4541782669e-06, 1.5992743742e-06, 1.7194673338e-06, 1.8150943962e-06, 1.8867387042e-06, 1.9352092825e-06, 1.9615193811e-06, 1.9668635208e-06, 1.9525935870e-06, 1.9201943142e-06, 1.8712584962e-06, 1.8074622400e-06, 1.7305405697e-06, 1.6422636642e-06, 1.5444139913e-06, 1.4387645756e-06, 1.3270586133e-06, 1.2109906146e-06, 1.0921892320e-06, 9.7220189568e-07, 8.5248135465e-07, 7.3437418709e-07, 6.1911131812e-07, 5.0780055343e-07, 4.0142111114e-07, 3.0082010894e-07, 2.0671094052e-07, 1.1967345374e-07, 4.0155824245e-08, -3.1521998405e-08, -9.5163409297e-08, -1.5068897995e-07, -1.9812916099e-07, -2.3761601956e-07, -2.6937417944e-07, -2.9371113275e-07, -3.1100709153e-07, -3.2170454392e-07, -3.2629767448e-07, -3.2532180081e-07, -3.1934296990e-07, -3.0894784686e-07, -2.9473401721e-07, -2.7730081109e-07, -2.5724074395e-07, -2.3513165443e-07, -2.1152960516e-07, -1.8696259810e-07, -1.6192514079e-07, -1.3687368619e-07, -1.1222295444e-07, -8.8343132082e-08, -6.5557931595e-08, -4.4143482806e-08, -2.4328017293e-08, -6.2922976469e-09, 9.8292645898e-09, 2.3946865196e-08, 3.6013006137e-08, 4.6019709490e-08, 5.3995321744e-08, 6.0000985295e-08, 6.4126854274e-08, 6.6488130959e-08, 6.7220997028e-08, 6.6478510946e-08, 6.4426538826e-08, 6.1239781454e-08, 5.7097954686e-08, 5.2182174508e-08, 4.6671591588e-08, 4.0740313387e-08, 3.4554644949e-08, 2.8270672406e-08, 2.2032206221e-08, 1.5969094293e-08, 1.0195908361e-08, 4.8110008357e-09, -1.0407677321e-10, -4.4848080991e-09, -8.2836180146e-09, -1.1469474085e-08, -1.4027210574e-08, -1.5956605232e-08}
  COEFFICIENT_WIDTH 24
  QUANTIZATION Maximize_Dynamic_Range
  BESTPRECISION true
  FILTER_TYPE Interpolation
  RATE_CHANGE_TYPE Fixed_Fractional
  INTERPOLATION_RATE 25
  DECIMATION_RATE 24
  NUMBER_CHANNELS 2
  NUMBER_PATHS 1
  SAMPLE_FREQUENCY 0.096
  CLOCK_FREQUENCY 125
  OUTPUT_ROUNDING_MODE Convergent_Rounding_to_Even
  OUTPUT_WIDTH 26
  M_DATA_HAS_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA subset_1/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_subset_converter
cell xilinx.com:ip:axis_subset_converter:1.1 subset_2 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 3
  TDATA_REMAP {tdata[23:0]}
} {
  S_AXIS fir_1/M_AXIS_DATA
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_dwidth_converter
cell xilinx.com:ip:axis_dwidth_converter:1.1 conv_1 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 3
  M_TDATA_NUM_BYTES 6
} {
  S_AXIS subset_2/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create blk_mem_gen
cell xilinx.com:ip:blk_mem_gen:8.3 bram_0 {
  MEMORY_TYPE True_Dual_Port_RAM
  USE_BRAM_BLOCK Stand_Alone
  WRITE_WIDTH_A 32
  WRITE_DEPTH_A 1024
  WRITE_WIDTH_B 32
  ENABLE_A Always_Enabled
  ENABLE_B Always_Enabled
  REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES false
}

# Create axi_bram_writer
cell pavel-demin:user:axi_bram_writer:1.0 writer_1 {
  AXI_DATA_WIDTH 32
  AXI_ADDR_WIDTH 32
  BRAM_DATA_WIDTH 32
  BRAM_ADDR_WIDTH 10
} {
  BRAM_PORTA bram_0/BRAM_PORTA
}

# Create axis_keyer
cell pavel-demin:user:axis_keyer:1.0 keyer_0 {
  AXIS_TDATA_WIDTH 32
  BRAM_DATA_WIDTH 32
  BRAM_ADDR_WIDTH 10
} {
  BRAM_PORTA bram_0/BRAM_PORTB
  cfg_data slice_2/Dout
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_subset_converter
cell xilinx.com:ip:axis_subset_converter:1.1 subset_3 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 4
  M_TDATA_NUM_BYTES 6
  TDATA_REMAP {24'b000000000000000000000000,tdata[23:0]}
} {
  S_AXIS keyer_0/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_switch
cell xilinx.com:ip:axis_switch:1.1 switch_0 {
  TDATA_NUM_BYTES.VALUE_SRC USER
  TDATA_NUM_BYTES 6
  ROUTING_MODE 1
  NUM_SI 2
  NUM_MI 1
} {
  S00_AXIS conv_1/M_AXIS
  S01_AXIS subset_3/M_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_broadcaster
cell xilinx.com:ip:axis_broadcaster:1.1 bcast_0 {
  S_TDATA_NUM_BYTES.VALUE_SRC USER
  M_TDATA_NUM_BYTES.VALUE_SRC USER
  S_TDATA_NUM_BYTES 6
  M_TDATA_NUM_BYTES 3
  M00_TDATA_REMAP {tdata[23:0]}
  M01_TDATA_REMAP {tdata[47:24]}
} {
  S_AXIS switch_0/M00_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create cic_compiler
cell xilinx.com:ip:cic_compiler:4.0 cic_1 {
  INPUT_DATA_WIDTH.VALUE_SRC USER
  FILTER_TYPE Interpolation
  NUMBER_OF_STAGES 6
  FIXED_OR_INITIAL_RATE 1250
  INPUT_SAMPLE_FREQUENCY 0.1
  CLOCK_FREQUENCY 125
  INPUT_DATA_WIDTH 24
  QUANTIZATION Truncation
  OUTPUT_DATA_WIDTH 24
  USE_XTREME_DSP_SLICE false
  HAS_DOUT_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA bcast_0/M00_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create cic_compiler
cell xilinx.com:ip:cic_compiler:4.0 cic_2 {
  INPUT_DATA_WIDTH.VALUE_SRC USER
  FILTER_TYPE Interpolation
  NUMBER_OF_STAGES 6
  FIXED_OR_INITIAL_RATE 1250
  INPUT_SAMPLE_FREQUENCY 0.1
  CLOCK_FREQUENCY 125
  INPUT_DATA_WIDTH 24
  QUANTIZATION Truncation
  OUTPUT_DATA_WIDTH 24
  USE_XTREME_DSP_SLICE false
  HAS_DOUT_TREADY true
  HAS_ARESETN true
} {
  S_AXIS_DATA bcast_0/M01_AXIS
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_combiner
cell  xilinx.com:ip:axis_combiner:1.1 comb_0 {
  TDATA_NUM_BYTES.VALUE_SRC USER
  TDATA_NUM_BYTES 3
} {
  S00_AXIS cic_1/M_AXIS_DATA
  S01_AXIS cic_2/M_AXIS_DATA
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create axis_constant
cell pavel-demin:user:axis_constant:1.0 phase_0 {
  AXIS_TDATA_WIDTH 32
} {
  cfg_data slice_1/Dout
  aclk /pll_0/clk_out1
}

# Create dds_compiler
cell xilinx.com:ip:dds_compiler:6.0 dds_0 {
  DDS_CLOCK_RATE 125
  SPURIOUS_FREE_DYNAMIC_RANGE 138
  FREQUENCY_RESOLUTION 0.2
  PHASE_INCREMENT Streaming
  HAS_TREADY true
  HAS_ARESETN true
  HAS_PHASE_OUT false
  PHASE_WIDTH 30
  OUTPUT_WIDTH 24
  DSP48_USE Minimal
} {
  S_AXIS_PHASE phase_0/M_AXIS
  aclk /pll_0/clk_out1
  aresetn slice_0/Dout
}

# Create axis_lfsr
cell pavel-demin:user:axis_lfsr:1.0 lfsr_0 {
  HAS_TREADY TRUE
} {
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create xlconstant
cell xilinx.com:ip:xlconstant:1.1 const_0

# Create cmpy
cell xilinx.com:ip:cmpy:6.0 mult_0 {
  FLOWCONTROL Blocking
  APORTWIDTH.VALUE_SRC USER
  BPORTWIDTH.VALUE_SRC USER
  APORTWIDTH 24
  BPORTWIDTH 24
  ROUNDMODE Random_Rounding
  OUTPUTWIDTH 26
} {
  S_AXIS_A comb_0/M_AXIS
  S_AXIS_B dds_0/M_AXIS_DATA
  S_AXIS_CTRL lfsr_0/M_AXIS
  m_axis_dout_tready const_0/dout
  aclk /pll_0/clk_out1
}

# Create axis_lfsr
cell pavel-demin:user:axis_lfsr:1.0 lfsr_1 {} {
  aclk /pll_0/clk_out1
  aresetn /rst_0/peripheral_aresetn
}

# Create xbip_dsp48_macro
cell xilinx.com:ip:xbip_dsp48_macro:3.0 mult_1 {
  INSTRUCTION1 RNDSIMPLE(A*B+CARRYIN)
  A_WIDTH.VALUE_SRC USER
  B_WIDTH.VALUE_SRC USER
  OUTPUT_PROPERTIES User_Defined
  A_WIDTH 24
  B_WIDTH 16
  P_WIDTH 16
} {
  A mult_0/m_axis_dout_tdata
  B slice_3/Dout
  CARRYIN lfsr_1/m_axis_tdata
  CLK /pll_0/clk_out1
}

# Create xbip_dsp48_macro
cell xilinx.com:ip:xbip_dsp48_macro:3.0 mult_2 {
  INSTRUCTION1 RNDSIMPLE(A*B+CARRYIN)
  A_WIDTH.VALUE_SRC USER
  B_WIDTH.VALUE_SRC USER
  OUTPUT_PROPERTIES User_Defined
  A_WIDTH 24
  B_WIDTH 16
  P_WIDTH 16
} {
  A mult_0/m_axis_dout_tdata
  B slice_4/Dout
  CARRYIN lfsr_1/m_axis_tdata
  CLK /pll_0/clk_out1
}
