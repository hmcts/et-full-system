module EtFullSystem
  module Test
    class Configuration
      include Singleton

      def _load
        source = File.join(File.dirname(__FILE__), '../../config/environment_config.yml')
        namespace = ENV.fetch('ENVIRONMENT', 'local')
        @data = YAML.load(ERB.new(File.read(source)).result, aliases: true)[namespace]
        @loaded = true
      end

      def self.method_missing(method, *args, &block)
        instance.send(method, *args, &block)
      end

      def self.respond_to_missing?(method, include_private = false)
        instance.respond_to?(method, include_private)
      end

      def respond_to_missing?(name, include_private)
        _load unless @loaded
        @data.key?(name.to_s) || super
      end

      def method_missing(symbol, *args)
        _load unless @loaded
        @data[symbol.to_s]
      end
    end
  end
end
