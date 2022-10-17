package main

import (
	"log"
	"math"
	"runtime"
	"sync"

	_ "go.uber.org/automaxprocs"
)

func SquareRoot() float64 {
	var x float64 = 0.001
	for i := 0; i < 1000000; i++ {
		x += math.Sqrt(x)
	}
	return x
}

func RunSquareRoot() {
	_ = SquareRoot()
	wg.Done()
}

var wg sync.WaitGroup

func main() {
	numThreads := runtime.GOMAXPROCS(0)

	log.Println("GOMAXPROCS set to ", numThreads)

	wg.Add(numThreads)

	for i := 0; i < numThreads; i++ {
		go RunSquareRoot()
	}

	wg.Wait()
}
