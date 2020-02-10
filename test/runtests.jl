module TestYARF
using Test
using YARF
using Aqua

#Aqua.test_all(YARF)

@testset "All" begin

    @test collect(moving_diff(3), 1:10) == [0, 1, 2, 3, 3, 3, 3, 3, 3, 3]
    @test collect(moving_diff(1), 1:10) == [0, 1, 1, 1, 1, 1, 1, 1, 1, 1]
end

end  # module