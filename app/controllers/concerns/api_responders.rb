# frozen_string_literal: true

module ApiResponders
  extend ActiveSupport::Concern

  private

    def render_error(message, status = :unprocessable_entity, context = {})
      error_message =
        if message.is_a?(StandardError)
          # If the exception has a record with errors, use that; otherwise, fall back to message.message.
          if message.respond_to?(:record) && message.record.present?
            message.record.errors_to_sentence
          else
            message.message
          end
        else
          message
        end

      render status: status, json: { error: error_message }.merge(context || {})
    end

    def render_notice(message, status = :ok, context = {})
      render status: status, json: { notice: message }.merge(context || {})
    end

    def render_json(json = {}, status = :ok)
      render status: status, json: json
    end
end
