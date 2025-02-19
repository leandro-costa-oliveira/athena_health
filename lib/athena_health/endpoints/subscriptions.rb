# frozen_string_literal: true

module AthenaHealth
  module Endpoints
    module Subscriptions
      SUBSCRIPTION_TYPES = [
        {
          collection_class: 'AppointmentCollection',
          path: 'appointments',
          name: 'appointment',
          plural_name: 'appointments',
          operations: ['changed'],
          event_suffix: ''
        },
        {
          collection_class: 'PatientCollection',
          path: 'patients',
          name: 'patient',
          plural_name: 'patients',
          operations: ['changed'],
          event_suffix: ''
        },
        {
          collection_class: 'ProviderCollection',
          path: 'providers',
          name: 'provider',
          plural_name: 'providers',
          operations: ['changed'],
          event_suffix: ''
        },
        {
          collection_class: 'PatientProblemCollection',
          path: 'chart/healthhistory/problems',
          name: 'patient_problem',
          plural_name: 'patient_problems',
          operations: ['changed'],
          event_suffix: ''
        },
        {
          collection_class: 'UserAllergyCollection',
          path: 'chart/healthhistory/allergies',
          name: 'patient_allergy',
          plural_name: 'patient_allergies',
          operations: ['changed'],
          event_suffix: ''
        },
        {
          collection_class: 'PrescriptionCollection',
          path: 'prescriptions',
          name: 'prescription',
          plural_name: 'prescriptions',
          operations: ['changed'],
          event_suffix: ''
        },
        {
          collection_class: 'UserMedicationCollection',
          path: 'chart/healthhistory/medication',
          name: 'patient_medication',
          plural_name: 'patient_medications',
          operations: ['changed'],
          event_suffix: ''
        },
        {
          collection_class: 'PrescriptionCollection',
          path: 'prescriptions',
          name: 'prescription',
          plural_name: 'prescriptions',
          operations: ['changed'],
          event_suffix: ''
        },
        {
          collection_class: 'Claim::ClaimCollection',
          path: 'claims',
          name: 'claim',
          plural_name: 'claims',
          operations: ['changed'],
          event_suffix: ''
        },
        {
          collection_class: 'OrderCollection',
          path: 'orders',
          name: 'order',
          plural_name: 'orders',
          operations: ['changed', 'signedoff'],
          event_suffix: '/events'
        }
      ].freeze

      SUBSCRIPTION_TYPES.each do |subscription_type|
        subscription_type[:operations].each do |operation|
          subscription_name = subscription_name(subscription_type:, operation:)

          define_method("#{subscription_name}_subscription") do |practice_id:, params: {}|
            response = @api.call(
              endpoint: "#{practice_id}/#{subscription_type[:path]}/#{operation}/subscription",
              method: :get,
              params: params
            )

            Subscription.new(response)
          end

          define_method("create_#{subscription_name}_subscription") do |practice_id:, params: {}|
            @api.call(
              endpoint: "#{practice_id}/#{subscription_type[:path]}/#{operation}/subscription",
              method: :post,
              params: params
            )
          end

          define_method("#{operation}_#{subscription_type[:plural_name]}") do |practice_id:, department_id: nil, params: {}|
            params[:departmentid] = department_id unless department_id.nil?
            response = @api.call(
              endpoint: "#{practice_id}/#{subscription_type[:path]}/#{operation}#{subscription_type[:event_suffix]}",
              method: :get,
              params: params
            )
            Object.const_get('AthenaHealth').const_get((subscription_type[:collection_class]).to_s).new(response)
          end
        end
      end

      def subscription_name(subscription_type:, operation:)
        return subscription_type[:name] if operation == 'changed'

        "#{operation}_#{subscription_type[:name]}"
      end
    end
  end
end
