# frozen_string_literal: true

module Types
  module Objects
    class Query < Types::Objects::Base
      field :node, field: GraphQL::Relay::Node.field
      field :nodes, field: GraphQL::Relay::Node.plural_field
      field :viewer, Types::Objects::UserType, null: true

      field :user, Types::Objects::UserType, null: true do
        argument :username, String, required: true
      end

      field :search_works, Types::Objects::WorkType.connection_type, null: true do
        argument :annict_ids, [Integer], required: false
        argument :seasons, [String], required: false
        argument :titles, [String], required: false
        argument :order_by, Types::InputObjects::WorkOrder, required: false
      end

      field :search_episodes, Types::Objects::EpisodeType.connection_type, null: true do
        argument :annict_ids, [Integer], required: false
        argument :order_by, Types::InputObjects::EpisodeOrder, required: false
      end

      field :search_people, Types::Objects::PersonType.connection_type, null: true do
        argument :annict_ids, [Integer], required: false
        argument :names, [String], required: false
        argument :order_by, Types::InputObjects::PersonOrder, required: false
      end

      field :search_organizations, Types::Objects::OrganizationType.connection_type, null: true do
        argument :annict_ids, [Integer], required: false
        argument :names, [String], required: false
        argument :order_by, Types::InputObjects::OrganizationOrder, required: false
      end

      field :search_characters, Types::Objects::CharacterType.connection_type, null: true do
        argument :annict_ids, [Integer], required: false
        argument :names, [String], required: false
        argument :order_by, Types::InputObjects::CharacterOrder, required: false
      end

      def viewer
        context[:viewer]
      end

      def user(username:)
        User.without_deleted.find_by(username: username)
      end

      def search_works(annict_ids: nil, seasons: nil, titles: nil, order_by: nil)
        SearchWorksQuery.new(
          annict_ids: annict_ids,
          seasons: seasons,
          titles: titles,
          order_by: order_by
        ).call
      end

      def search_episodes(annict_ids: nil, order_by: nil)
        SearchEpisodesQuery.new(
          annict_ids: annict_ids,
          order_by: order_by
        ).call
      end

      def search_people(annict_ids: nil, names: nil, order_by: nil)
        SearchPeopleQuery.new(
          annict_ids: annict_ids,
          names: names,
          order_by: order_by
        ).call
      end

      def search_organizations(annict_ids: nil, names: nil, order_by: nil)
        SearchOrganizationsQuery.new(
          annict_ids: annict_ids,
          names: names,
          order_by: order_by
        ).call
      end

      def search_characters(annict_ids: nil, names: nil, order_by: nil)
        SearchCharactersQuery.new(
          annict_ids: annict_ids,
          names: names,
          order_by: order_by
        ).call
      end
    end
  end
end
