# vlog8_shortestpath
I've made some enhancement to the shortest path program.  It now has route tracking so we know the steps taken to reach the shortest path.

In addition to that I've also updated the software that now it is now using modern dynamic array and tested to find shortest path on data size up to 1 million vertices.

Enhancement can also be found on the input generator. It now produces better data that is more relevant.  From vertex 1, for example, can only have direct connection to vertex 10.  This is controlled by variable interval on line 10.  So no more connection from vertex 1 to 1000000 directly.

I still strongly discourage the use of this algorithm in production even though for all the tests I conducted with this algorithm produces the same result as Floyd-Warshall's algorithm.  The correctness of this algorithm has not yet been proven, especially on larger input as I have no way to confirm it.

Delphi version is updated to 10.3 Rio as it can compile 64 bit binary even on Free Community Edition.
Delphi is availabe from https://www.embarcadero.com/products/delphi/product-editions
Please choose 64 bit install to run my application
