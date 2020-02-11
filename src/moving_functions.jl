using Transducers
using StaticArrays


apply_moving(delta::Int, f) =
    ScanEmit((1, nothing, nothing)) do (k, buf, y), x
        if buf === nothing
            buf = fill(x, delta)
            y = x
        end
        y = @inbounds f(delta, k, buf, y, x)
        @inbounds buf[k] = x
        k += 1
        return y, (ifelse(k == delta + 1, 1, k), buf, y)
    end

avg_update(delta::Int, k::Int, buf, y_pred, x) = y_pred + (x - buf[k]) / delta

moving_avg(delta::Int) = apply_moving(delta::Int, avg_update)

moving_diff(delta::Int) = apply_moving(delta, (k, buf, y_pred, x) -> x - buf[k])

# todo cumulative_avg