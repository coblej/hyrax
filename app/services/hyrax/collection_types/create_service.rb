module Hyrax
  module CollectionTypes
    # @api public
    #
    # Responsible for creating a CollectionType. If no params are given,the default user collection is assumed as defined by:
    #
    # * Hyrax::CollectionType::USER_COLLECTION_MACHINE_ID
    # * Hyrax::CollectionType::USER_COLLECTION_DEFAULT_TITLE
    # * DEFAULT_OPTIONS
    #
    # @see Hyrax:CollectionType
    #
    class CreateService
      DEFAULT_MACHINE_ID = Hyrax::CollectionType::USER_COLLECTION_MACHINE_ID
      DEFAULT_TITLE = Hyrax::CollectionType::USER_COLLECTION_DEFAULT_TITLE
      DEFAULT_OPTIONS = {
        description: 'A User Collection can be created by any user to organize their works.',
        nestable: true,
        discoverable: true,
        sharable: true,
        allow_multiple_membership: true,
        require_membership: false,
        assigns_workflow: false,
        assigns_visibility: false,
        participants: [{ agent_type: 'group', agent_id: 'admin', access: 'manage' },
                       { agent_type: 'group', agent_id: 'registered', access: 'create' }]
      }.freeze

      # @param machine_id [String]
      # @param title [String]
      # @param options [Hash] options to override DEFAULT_OPTIONS
      # @return [Hyrax::CollectionType]
      def self.create_collection_type(machine_id: DEFAULT_MACHINE_ID, title: DEFAULT_TITLE, options: {})
        opts = DEFAULT_OPTIONS.merge(options)
        ct = Hyrax::CollectionType.create(machine_id: machine_id, title: title) do |c|
          c.description = opts[:description]
          c.nestable = opts[:nestable]
          c.discoverable = opts[:discoverable]
          c.sharable = opts[:sharable]
          c.allow_multiple_membership = opts[:allow_multiple_membership]
          c.require_membership = opts[:require_membership]
          c.assigns_workflow = opts[:assigns_workflow]
          c.assigns_visibility = opts[:assigns_visibility]
        end
        add_participants(ct.id, opts[:participants])
        ct
      end

      # @param collection_type_id [Integer]
      # @param participants [Array]
      def self.add_participants(collection_type_id, participants)
        return unless collection_type_id && participants.count > 0
        participants.each do |p|
          agent_type = p[:agent_type]
          agent_id = p[:agent_id]
          access = p[:access]
          Hyrax::CollectionTypeParticipant.create(hyrax_collection_type_id: collection_type_id, agent_type: agent_type, agent_id: agent_id, access: access)
        end
      end
    end
  end
end
