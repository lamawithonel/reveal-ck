#
# Setup Slim
require 'slim'
::Slim::Engine.set_options pretty: true

require 'tilt'

module RevealCK
  module Templates
    # Public: A Processor is given a template and expected to render
    # it.
    class Processor
      include Retrieve

      attr_reader :config

      def initialize(args)
        file, @config = retrieve(:file, args), retrieve(:config, args)
        @template = Tilt.new file
      end

      def output(locals = {})
        scope = RevealCK::Render::Scope.new(dir: Dir.pwd, config: config)
        @template.render scope, locals
      end

      def self.open(args)
        file, config = retrieve(:file, args), retrieve(:config, args)
        Processor.new(file: file, config: config)
      end
    end
  end
end
