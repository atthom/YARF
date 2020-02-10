using Transducers

moving_diff(delta::Int) =
    ScanEmit((1, nothing)) do (k, buf), x
        if buf === nothing
            buf = fill(x, delta)
        end
        y = @inbounds x - buf[k]
        @inbounds buf[k] = x
        k += 1
        return y, (ifelse(k == delta + 1, 1, k), buf)
    end


apply_moving(delta::Int, f) =
    ScanEmit((1, nothing)) do (k, buf), x
        if buf === nothing
            buf = fill(x, delta)
        end
        y = @inbounds f(x, buf[k])
        @inbounds buf[k] = x
        k += 1
        return y, (ifelse(k == delta + 1, 1, k), buf)
    end