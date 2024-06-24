class DemoContent
  class << self
    def import(user)
      import_fixtures("book") do |book|
        # book.update_access(readers: [], editors: [ user.id ])
      end

      %w[ page picture section leaf action_text/markdown ].each do |kind|
        import_fixtures(kind)
      end
    end

    private
      def import_fixtures(kind)
        klass = kind.classify.constantize
        filenames = Dir.glob(Rails.root.join("app/fixtures/#{kind}/*.yml"))
        filenames.each do |file|
          args = YAML.load_file(file)

          puts "Creating #{kind} #{args}"
          instance = klass.create!(args)
          yield instance if block_given?
        end
      end
  end
end
