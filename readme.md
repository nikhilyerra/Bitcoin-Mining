
  # Project 1 - Distributed BitCoin Mining
  ### COP5615 Distributed Operating Systems at the University of Florida.

## Goal of the project

The project's objective is to use an actor model to produce bitcoins with the necessary number of leading zeros. It has also been expanded to include additional machines in the process of creating bitcoin.

## Contribution

* *Ujwala Guttikonda* , UFID 57914323,  ujwalaguttikonda@ufl.edu

* *Nikhil Yerra* , UFID 95453265,  nikhil.yerra@ufl.edu

  
## Steps to execute the code

  

Using an actor model for bitcoin mining,  run the following commands in the project's directory: 

  

1. Open the command prompt in the project directory and run the following command to initialize the Server

  

```bash

erl -name servername@IPaddress -setcookie cookie_name

```


2. Parallelly open another command prompt in the project's directory to initialize the client and run the following command.


```bash

erl -name clientname@IPaddress -setcookie cookie_name

```

 3. Run the following command to start the server with the input parameter being the number of leading zeroes to be present in the hashed value. 
 - Server will start mining coins

  
  

```bash

server:start(number_of_leading_zeroes).

```

  
  

 4. In the client command prompt, run the following command to start the client.
 - When the client gets connected to the server, concurrently both server and client will start mining the coins. 

  

```bash

client:init(servername@IPaddress).

```

  

## Result

  

1. Size of work unit: Instead of assigning part of the mining process to each worker, each worker was assigned an individual task of mining. In general, most computers have an average of 4 or 6 cores. Hence, on each request, 10 processes were spawned on the worker to optimise the mining process.
  
  
  

2. Part of the output While mining for 1400 coins with four leading zeroes is displayed below

  
  
```bash
(ujw@Ujwala)4> "57914323:Xb7gBI3oMWTa"  "0000d5d909532b97a6742e817b56f0c0784a371935abfccf76f36ea31f366e29"
(ujw@Ujwala)4> "57914323:7fW46tN18brD"  "00001ca3112e15ffc3e3f45f55c760b286865f4d513adc7b0020a6038b0f6965"
(ujw@Ujwala)4> "57914323:SYae3ja55TUT"  "0000d044ccb7bd5c2e089225e61d0a95f636c6fa099478d479e90c9dad7a34ef"
(ujw@Ujwala)4> "57914323:ESAA0pz+GuFv"  "000088e9703109d34193ddc810e7fdd6c8ee5e4d507b594eef422044db00fef6"
(ujw@Ujwala)4> "57914323:9tuBC76mTItC"  "0000bbdebabb1b01c90208e0f435420718d7c79f15356935a4ce3c88673eb345"
(ujw@Ujwala)4> "57914323:Mf9yBU34n6YR"  "000063085f8f7c5770b486aa3dc32f5ac4fa971d0aa784a24a7cacea11c5d1ec"

(ujw@Ujwala)4> CPU time: 134589, Real time: 23320, CPU/Real: 5.77139794168096

(ujw@Ujwala)4> Completed mining 1400 coins

```

  * CPU time (time across all erlang runtime threads): = 134589 Real time: 23320; 

   * CPU/Real:  **5.77139794168096**

  

* The coin with most zeroes we could be found is  **6** 
` "57914323:I15Fz25le2ZK""0000006401a1916a86db887d364926fa6f1b28087eedcc6d216df9bc7e23948e" `

-   The largest number of working machines we were able to run code is  **5**
   
The details are as follows:
ASUS Intel® Core i7-12650H processor M2 chip: 8-core CPU
Lenovo Intel® Core i7-12650H processor, 10 cores
Lenovo Intel® Intel Core i7-7700HQ processor, 4 cores
Apple M1 chip: 8-core CPU
Apple M1 chip: 8-core CPU


## Contributing

Pull requests are welcome. Please start an issue to discuss your desired changes before making any big ones.

Please make sure to update tests as appropriate.

Thank you.
