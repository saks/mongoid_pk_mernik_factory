require 'teststrap'

context "mongoid_pk_factory" do
  example_document = Class.new
  example_document.class_eval do
    include Mongoid::Document
  end

  context "with default settings" do

    should "use object ID primary keys" do
      example_document.new.id
    end.matches(/^[a-f0-9]{24}$/i)

  end # with default settings

  context "with a pk factory set on the mongo driver" do
    setup do
      pk_factory = stub!
      pk_factory.create_pk(anything) { {:_id => "a_primary_key"} }
      stub(Mongoid.master).pk_factory { pk_factory }
    end

    should "use the pk generated by the factory" do
      example_document.new.id
    end.equals("a_primary_key")
  end # with a pk factory set on the mongo driver
end   # mongoid_pk_factory
