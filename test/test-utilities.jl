println(@__FILE__)
print_rng()

@testset "MvNormal loggradient" begin
    for _ in 1:10
        K = rand(2:6)
        ℓ = MvNormal(randn(K), full(rand_Σ(K)))
        for _ in 1:10
            test_loggradient(ℓ, randn(K))
        end
    end
end

struct Foo{T}
    a::T
    b::T
end

@testset "≂ comparisons" begin
    @test 1 ≂ 1
    @test 1 ≂ 1.0
    @test [1,2] ≂ [1,2]
    @test [1.0,2.0] ≂ [1,2]
    @test !(1 ≂ 2)
    @test Foo(1,2) ≂ Foo(1,2)
    @test !(Foo(1,2) ≂ Foo(1,3))
    @test !(Foo{Any}(1,2) ≂ Foo(1,2))
end

@testset "simulated meancov" begin
    d = MvNormal([2,2], [2.0,1.0])
    m, C = simulated_meancov(()->rand(d), 10000)
    @test m ≈ mean(d) atol = 0.05
    @test C ≈ cov(d) atol = 0.05 rtol = 0.1
end
