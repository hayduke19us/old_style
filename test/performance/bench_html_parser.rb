require 'helper'

class BenchKlass < Minitest::Benchmark
  include HtmlParser

  if ENV["BENCH"]

    def setup
      file = File.expand_path("../../../app", __FILE__)
      @file = file + "/views/fake/fake.html.erb"
    end

    def bench_remove_extras
      assert_performance_linear 0.99 do |n|
        n.times do
          remove_extras(@file)
        end
      end
    end

    def bench_id_spike
      assert_performance_linear 0.99 do |n|
        n.times do
          id_spike("#salinger", @file)
        end
      end
    end

    def bench_id_exists?
      assert_performance_linear 0.99 do |n|
        n.times do
          id_exists?("#salinger", @file)
        end
      end
    end

  end

end

