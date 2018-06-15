# frozen_string_literal: true

module OrangeData
  module PipelineMixin

    Succ = Struct.new(:result) do
      def success?; true; end

      def fail?; false; end
    end

    Fail = Struct.new(:error) do
      def success?; false; end

      def fail?; true; end
    end

    def run_pipeline(obj, methods)
      methods.reduce(Succ.new(obj)) do |res, m|
        if res.success?
          m.is_a?(Array) ? send(m.first, res.result, *m[1..-1]) : send(m, res.result)
        else
          break(res)
        end
      end
    end
  end
end
